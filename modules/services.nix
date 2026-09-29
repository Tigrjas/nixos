{ pkgs, ... }:

{
  # Printing
  services.printing.enable = true;

  # Network printer/scanner discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan
    ];
  };

  # Other services
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
