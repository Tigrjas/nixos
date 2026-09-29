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
    user = "jason";
    dataDir = "/home/jason";
    openDefaultPorts = true;
  
    settings = {
      devices = {
        homeserver = {
          id = "6TPFK67-WJHYIDN-ZZPTBQV-BRWRX4L-UXH35XH-VGJBEC6-W2XO7QS-NDYXFAB";
        };
      };
  
      folders = {
        Chronos = {
          path = "/home/jason/Documents/Chronos";
          devices = [ "homeserver" ];
        };
      };
    };
  };

  fileSystems."/mnt/shared" = {
    device = "192.168.5.40:/mnt/data/shared";
    fsType = "nfs";
    options = [
      "_netdev"
      "nofail"
    ];
  };

  environment.systemPackages = with pkgs; [
    openssh
    nfs-utils
  ];
}
