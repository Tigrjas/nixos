{ pkgs, ... }:

{
  services.printing.enable = true;

  services.flatpak.enable = true;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  environment.systemPackages = with pkgs; [
    openssh
    nfs-utils
  ];
}
