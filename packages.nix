{ config, lib, pkgs, ... }: {

  # Allow unfree
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

  # Automatically update nix channels
  system.autoUpgrade.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    # Automatically clean nixos build entries
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Overlays
  nixpkgs.overlays = [];

  home-manager.users.${config.user.name} = {
    xdg.configFile.nixpkgs = {
      target = "nixpkgs/config.nix";
      source = ./nixpkgs.nix;
    };

    home.packages = with pkgs; [
      qdigidoc
      vmware-horizon-client
      neofetch
      sl
      arandr
      pavucontrol # Audio control
      pocket-casts # Podcasts
      spotify
      vlc # Media Player
      glow # Readme reader
      bitwarden # Password manager
      simple-scan # Scan
      okular # PDF viewer
      gnome.file-roller # Archive Manager
      pcmanfm # File Manager
      rsync # Syncer $ rsync -r dir1/ dir2/
      unzip zip # Zip files
      unrar # Rar files
      xclip
      # playerctl
      # pulseaudio
      qpwgraph
      killall
      youtube-dl
      ripgrep
      procs
      fd
      sd
      inetutils
      discord
      slack
      tmatrix
      insomnia
      dbeaver
      mongodb-compass
      protonvpn-gui
      kdenlive
      ranger
      drawio
      gh
      just
      tdesktop
      pup
    ];
  };
}
