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
      chatterino2                       # twitch

      molotov                           # TV player
      vlc                               # Video viewer
      qview                             # Image viewer
      glow                              # Markdown viewer
      gnome3.gnome-screenshot           # Screenshot
      tmatrix

      # Dev tools
      insomnia
      awscli
      google-cloud-sdk
      dbeaver
      robomongo
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
