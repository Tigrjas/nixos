{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

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

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  xdg.configFile."kitty/kitty.conf".source =
    ./kitty/kitty.conf;

  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  xdg.configFile."noctalia/config.toml".source =
    ./noctalia/config.toml;

  xdg.configFile."fish" = {
    source = ./fish;
    recursive = true;
  };

  xdg.configFile."fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };

  home.file.".local/bin/cycle-sink" = {
    source = ../scripts/cycle-sink.sh;
    executable = true;
  };

  programs.ssh = {
    enable = true;
  
    matchBlocks = {
      homeserver = {
        hostname = "192.168.5.40";
        user = "jason";
      };
    };
  };

  home.stateVersion = "26.05";
}
