{ config, lib, pkgs, ... }: {

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

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
  nixpkgs.overlays = [
    # Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "sha256:1kwqn1xr96kvrlbjd14m304g2finc5f5ljvnklg6fs5k4avrvmn4";
          };
        }
      );
    })
  ];

  home-manager.users.${config.user.name} = {
    xdg.configFile.nixpkgs = {
      target = "nixpkgs/config.nix";
      text = ''
        { allowUnfree = true; }
      '';
    };

    home.packages = with pkgs; [
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
      playerctl
      pulseaudio
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
    ];
  };
}
