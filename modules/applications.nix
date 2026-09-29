{ pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    brave
    discord
    kitty
    libreoffice-still
    nautilus
    obsidian
    simple-scan
    spotify
    zed-editor

    # Keep Kate around while Plasma is our fallback.
    kdePackages.kate
  ];
}
