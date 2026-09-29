{ config, pkgs, inputs, ... }:

{
  home.username = "jason";
  home.homeDirectory = "/home/jason";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jason Tran";
        email = "jasontran893code@gmail.com";
      };
    };
  };

  home.stateVersion = "26.05";
}
