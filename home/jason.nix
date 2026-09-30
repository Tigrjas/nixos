{ inputs, ... }:

{
  # ============================================================
  # Imports
  # ============================================================

  imports = [
    inputs.zen-browser.homeModules.beta
  ];


  # ============================================================
  # Home Manager
  # ============================================================

  home.username = "jason";
  home.homeDirectory = "/home/jason";

  programs.home-manager.enable = true;


  # ============================================================
  # Git
  # ============================================================

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jason Truong Tran";
        email = "YOUR_EMAIL_ADDRESS";
      };
    };
  };


  # ============================================================
  # SSH
  # ============================================================

  programs.ssh = {
    enable = true;

    matchBlocks = {
      homeserver = {
        hostname = "192.168.5.40";
        user = "jason";
      };
    };
  };


  # ============================================================
  # Applications
  # ============================================================

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };


  # ============================================================
  # Kitty
  # ============================================================

  xdg.configFile."kitty/kitty.conf".source =
    ./kitty/kitty.conf;


  # ============================================================
  # Niri
  # ============================================================

  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };


  # ============================================================
  # Noctalia
  # ============================================================

  xdg.configFile."noctalia/config.toml".source =
    ./noctalia/config.toml;


  # ============================================================
  # Fish
  # ============================================================

  xdg.configFile."fish" = {
    source = ./fish;
    recursive = true;
  };


  # ============================================================
  # Fastfetch
  # ============================================================

  xdg.configFile."fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };


  # ============================================================
  # Custom Scripts
  # ============================================================

  home.file.".local/bin/cycle-sink" = {
    source = ../scripts/cycle-sink.sh;
    executable = true;
  };

  home.file.".local/bin/nixos-update" = {
    source = ../scripts/nixos-update.sh;
    executable = true;
  };


  # ============================================================
  # Home Manager State Version
  #
  # Do not change this after the initial setup.
  # ============================================================

  home.stateVersion = "26.05";
}
