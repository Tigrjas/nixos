{ pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
    bitwarden-desktop
    brave
    discord
    kitty
    libnotify
    libreoffice-still
    nautilus
    obsidian
    pavucontrol
    simple-scan
    spotify
    zed-editor

    # Keep Kate around while Plasma is our fallback.
    kdePackages.kate
  ];
}
