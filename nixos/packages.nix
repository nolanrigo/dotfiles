{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  nixpkgs.config.allowUnfree = true;
  home-manager.users."${params.username}" = {
    # Accept unfree package
    nixpkgs.config.allowUnfree = true;
    xdg.configFile.nixpkgs = {
      target = "nixpkgs/config.nix";
      text = ''
        { allowUnfree = true; }
      '';
    };


    home.packages = with pkgs; [
      # Doc
      libreoffice

      # Messaging
      discord
      tdesktop
      signal-desktop
      slack

      # Media
      spotify
      vlc
      molotov

      # Dev tools
      insomnia
      awscli
      dbeaver

      # Printscreen
      gnome3.gnome-screenshot
    ];
  };

  # Minial packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    mkpasswd
  ];
}
