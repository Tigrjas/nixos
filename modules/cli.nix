{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    curl
    fastfetch
    micro
    pciutils
    pulseaudio
    restic
    rsync
    util-linux
    wget
  ];
}
