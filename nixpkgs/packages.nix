{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    lastpass-cli

    # Editing
    kdenlive
    audacity

    # Download
    transmission-gtk

    # Print Scan
    gnome3.simple-scan
    system-config-printer

    # Network
    networkmanagerapplet

    # File
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-dropbox-plugin
    xfce.thunar-volman
    xfce.tumbler

    # Media
    pavucontrol
    spotify
    vlc

    # Dev
    insomnia
    awless
    awscli
    sqliteman
    dbeaver
    mysql-workbench
    docker-compose
    gcc
    tldr

    # Messaging
    tdesktop
    discord
    slack

    # General
    xclip xsel # X clipboard console support
    et
    glow

    # Utils
    zip unzip p7zip unrar # archive tools
    arandr
    nox
    blueman
    qview
    fontmatrix
    neofetch
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    pulseaudio-ctl
    brightnessctl
    playerctl
    usbutils
    diskonaut

    # Needed
    psmisc
    pantheon.elementary-screenshot-tool
  ];

  programs = {
    obs-studio.enable = true;
    man.enable = true;
    lsd.enable = true;
    bat.enable = true;
  };

}
