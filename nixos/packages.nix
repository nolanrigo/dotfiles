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
      # Messaging
      discord
      tdesktop
      slack

      # Music
      spotify
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
