{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan
    ];
  };

  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.super_productivity.SuperProductivity"
    ];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  environment.systemPackages = with pkgs; [
    openssh
    nfs-utils
  ];
}
