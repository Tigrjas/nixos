{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # RTX 2070 is Turing, so it supports NVIDIA's open kernel module.
    open = true;

    # Use the packaged stable NVIDIA driver.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
