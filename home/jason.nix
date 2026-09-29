{ config, pkgs, inputs, ... }:

{
  home.username = "jason";
  home.homeDirectory = "/home/jason";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jason Truong Tran";
        email = "YOUR_EMAIL_ADDRESS";
      };
    };
  };

  xdg.configFile."kitty/kitty.conf".source =
    ./kitty/kitty.conf;
    
  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  xdg.configFile."fish" = {
    source = ./fish;
    recursive = true;
  };

  xdg.configFile."noctalia/config.toml".source =
    ./noctalia/config.toml;

  home.stateVersion = "26.05";
}
