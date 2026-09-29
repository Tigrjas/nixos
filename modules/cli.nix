{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    micro
    restic
    rsync
    wget
  ];
}
