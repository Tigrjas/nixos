function fish_prompt
    # Save the exit status of the previous command before running
    # anything else in the prompt.
    set -l last_status $status

    # ------------------------------------------------------------
    # user@hostname
    # ------------------------------------------------------------

    set_color green
    printf '%s@%s ' $USER (prompt_hostname)


    # ------------------------------------------------------------
    # Current directory
    #
    # Show the full path instead of Fish abbreviating directories.
    # Replace /home/jason with ~ for readability.
    # ------------------------------------------------------------

    set_color cyan

    set -l current_dir (string replace "$HOME" "~" "$PWD")

    printf '%s' $current_dir


    # ------------------------------------------------------------
    # Git / version control status
    #
    # Examples:
    #   (main)
    #   (main *)
    # ------------------------------------------------------------

    set_color normal
    fish_vcs_prompt


    # ------------------------------------------------------------
    # Previous command failure
    #
    # Only shown when the previous command returned a non-zero
    # exit status.
    #
    # Example:
    #   [127]
    # ------------------------------------------------------------

    if test $last_status -ne 0
        set_color red
        printf ' [%d]' $last_status
    end


    # ------------------------------------------------------------
    # Prompt character
    # ------------------------------------------------------------

    set_color normal
    printf '> '
end
