{ pkgs, config, lib, ... }:

let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
in {
  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/resources/home-manager";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  imports = [
    ./config/firefox.nix
    ./config/dropbox.nix
    ./config/qutebrowser.nix
    ./config/pazi.nix
    ./config/theme.nix
    ./config/xcape.nix
    ./config/grobi.nix
    ./config/fish.nix
    ./config/starship.nix
    ./config/alacritty.nix
    ./config/git.nix
    ./config/htop.nix
    ./config/i3.nix
    ./config/neovim.nix
    ./config/polybar.nix
    ./config/picom.nix
    ./config/rofi.nix
    ./config/ssh.nix
    ./config/zathura.nix
    ./config/dunst.nix
    ./config/direnv.nix
    ./config/autorandr.nix
    ./config/mcfly.nix
    ./packages.nix
  ];

  systemd.user.startServices = true;
  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
    configFile.nixpkgs = { # allowUnfree for nix-shell -p
      target = "nixpkgs/config.nix";
      text = ''
        { allowUnfree = true; }
      '';
    };
  };

  home = {
    sessionVariables = {
      COLORTHEME = "onedark";
      EDITOR = "nvim";

      # Disable random stuffs
      NEXT_TELEMETRY_DISABLED = 1;
    };
    keyboard = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  services = {
    udiskie.enable = true;
    redshift = {
      enable = true;
      provider = "geoclue2";
    };
    clipmenu.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    unclutter = {
      enable = true;
      timeout = 5;
    };
    # nextcloud-client.enable = true;
    gnome-keyring = {
      enable = true;
      components = [
        "secrets"
        "pkcs11"
        "ssh"
      ];
    };
  };

}
