#!/usr/bin/env bash

set -euo pipefail

DIRECTION="${1:-next}"

NVIDIA_CARD="alsa_card.pci-0000_09_00.1"

LG_PROFILE="output:hdmi-stereo-extra1"
LG_SINK="alsa_output.pci-0000_09_00.1.hdmi-stereo-extra1"

TV_PROFILE="output:hdmi-stereo-extra2"
TV_SINK="alsa_output.pci-0000_09_00.1.hdmi-stereo-extra2"

declare -a targets

# ------------------------------------------------------------
# Fixed NVIDIA HDMI destinations
# Format:
#   type|profile|sink|friendly name
# ------------------------------------------------------------

targets+=(
    "profile|${LG_PROFILE}|${LG_SINK}|LG Monitor"
)

targets+=(
    "profile|${TV_PROFILE}|${TV_SINK}|Samsung TV"
)

# ------------------------------------------------------------
# Dynamically add other currently available sinks.
#
# This includes:
#   USB headphones
#   AirPods
#   future Bluetooth / USB audio devices
#
# Ignore:
#   NVIDIA sinks (handled above)
#   motherboard S/PDIF
# ------------------------------------------------------------

while read -r sink; do
    [[ -z "$sink" ]] && continue

    case "$sink" in
        alsa_output.pci-0000_09_00.1.*)
            continue
            ;;

        *iec958*)
            continue
            ;;
    esac

    case "$sink" in
        *Sound_Blaster_Play*)
            friendly="USB Headphones"
            ;;

        bluez_output.*)
            friendly="AirPods / Bluetooth Headphones"
            ;;

        *)
            friendly="$sink"
            ;;
    esac

    targets+=(
        "sink||${sink}|${friendly}"
    )

done < <(
    pactl list short sinks |
    awk '{print $2}'
)

if (( ${#targets[@]} == 0 )); then
    notify-send \
        --expire-time=1500 \
        "Audio Output" \
        "No audio outputs available"
    exit 1
fi

# ------------------------------------------------------------
# Determine current output
# ------------------------------------------------------------

current_sink="$(pactl get-default-sink)"

current_index=-1

for i in "${!targets[@]}"; do
    IFS='|' read -r type profile sink friendly <<< "${targets[$i]}"

    if [[ "$sink" == "$current_sink" ]]; then
        current_index="$i"
        break
    fi
done

# ------------------------------------------------------------
# Choose next / previous
# ------------------------------------------------------------

if [[ "$DIRECTION" == "previous" ]]; then

    if (( current_index <= 0 )); then
        target_index=$((${#targets[@]} - 1))
    else
        target_index=$((current_index - 1))
    fi

else

    target_index=$(( (current_index + 1) % ${#targets[@]} ))

fi

IFS='|' read -r type profile sink friendly \
    <<< "${targets[$target_index]}"

# ------------------------------------------------------------
# NVIDIA HDMI profile switch
# ------------------------------------------------------------

if [[ "$type" == "profile" ]]; then

    pactl set-card-profile "$NVIDIA_CARD" "$profile"

    # Changing the profile destroys the old HDMI sink and creates
    # the new one. Give PipeWire a moment to expose it.
    for _ in {1..20}; do

        if pactl list short sinks |
            awk '{print $2}' |
            grep -Fxq "$sink"
        then
            break
        fi

        sleep 0.1
    done

    if ! pactl list short sinks |
        awk '{print $2}' |
        grep -Fxq "$sink"
    then
        notify-send \
            --expire-time=1500 \
            "Audio Output" \
            "Failed to activate $friendly"

        exit 1
    fi

fi

# ------------------------------------------------------------
# Set default output
# ------------------------------------------------------------

pactl set-default-sink "$sink"

# ------------------------------------------------------------
# Move already-running applications
# ------------------------------------------------------------

while read -r input_id _; do

    [[ -n "$input_id" ]] || continue

    pactl move-sink-input "$input_id" "$sink" || true

done < <(
    pactl list short sink-inputs
)

# ------------------------------------------------------------
# Notification
# ------------------------------------------------------------
