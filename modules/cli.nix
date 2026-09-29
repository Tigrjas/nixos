{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    micro
    pciutils
    restic
    rsync
    wget
  ];
}
