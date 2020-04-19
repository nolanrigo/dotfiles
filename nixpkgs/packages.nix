{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    # Main
    brave

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
    exercism
    awless
    awscli
    sqliteman
    dbeaver
    mysql-workbench
    docker-compose
    gcc

    # Messaging
    tdesktop
    discord
    slack

    # General
    xclip xsel # X clipboard console support
    et

    # Utils
    zip unzip p7zip unrar # archive tools
    nox
    blueman
    jq
    neofetch
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    tldr

    # Yubikey
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt

    # Needed
    psmisc
    # playerctl
    # pulseaudio-ctl
    deepin.deepin-screenshot

    # qgis libnotify logisim

    # Considering:
    # passExtensions.pass-audit   # pass: auditing command
    # passExtensions.pass-update  # pass: updating command
    # weechat # IRC client (TODO replace hexchat)
    # sway    # window manager for Wayland, compatible with i3
    # xmonad  # tiling window manager for X, configured in Haskell
    # buku    # bookmark manager

    # Waiting for:
    # bitwarden-cli # NixOS/nixpkgs: #51212 #53876
    # bitwarden     # NixOS/nixpkgs: #51212
    # jabref        # NixOS/nixpkgs: #47113
    # passExtensions.pass-tomb # zeapo/Android-Password-Store: #329

    # System requirements (TODO nixify)
    # blueman # bluetooth manager
    # hicolor-icon-theme # icon theme
    # librsvg # SVG renderer
    # networkmanagerapplet  # network manager

    # system info
    # acpi # power management and info
    # pciutils # PCI bus utilities
    # lshw # hardware config info

    # Userspace utilities
    # coreutils # basic utilities
    # dos2unix  # line break converter
    # file # file info
    # inetutils # network utilities
    # nox # nix tools
    # psmisc lsof # process utilities
    # qrencode # QR code encoder
    # trash-cli # trash can
    # tree # depth-indented directory listing
    # usbutils # USB device tools
    # curl wget youtube-dl # downloaders

    # Development
    # jetbrains.idea-ultimate # Java IDE (UNFREE)
    # adoptopenjdk-hotspot-bin-11 maven3 # TODO nixify local Java projects
    # jetbrains.pycharm-professional # Python IDE (UNFREE)
    # python3 # TODO nixify Python projects
    # universal-ctags # source code indexer (TODO Vim tagbar dependency)
    # coq # proof assistant
    # tlaplusToolbox tlaps # TLA+ tools
    # rstudio # R tools
    # rustc cargo
    # nixops

    # Security
    # gnupg # openpgp
    # pass # password manager
    # tomb # storage file encryption
    # gksu # su frontend

    # Textual applications
    # diction # English linter
    # libqalculate # calculator
    # ranger atool # file manager
    # hledger # accounting tool

    # Games
    # multimc minecraft jre8
    # scid-vs-pc stockfish

    # Graphical applications
    # calibre # ebook manager
    # digikam # photo manager
    # emacs emacs-all-the-icons-fonts # text editor
    # goldendict # dictionary client
    # hexchat # IRC client
    # inkscape # vector graphics editor
    # lyx # LaTeX editor
    #nextcloud-client # cloud storage client
    # qalculate-gtk # calculator
    # qbittorrent # bittorrent client
    # qutebrowser # vi-like web browser
    # signal-desktop # messaging client
    # skype # video chat client (UNFREE)
    # zim # desktop wiki
    # zotero # reference management

    # General:
    # byzanz scrot vokoscreen # screen capture
    # gparted # disk partitioner
    # imagemagick # bitmap image editor
    # mediainfo # multimedia info
    # mkvtoolnix # matroska tools
    # pandoc # markup converter
    # redshift # screen color temperature manager
    # rxvt_unicode-with-plugins # terminal emulator
    # scrcpy # Android remote control and display
    # sshfs # remote filesystem mounter
    # sxiv # image viewer
    # texlive.combined.scheme-full # TeX Live
    # xdg-user-dirs
    # xdg_utils
    # xxd # create or reverse hexdumps
  ];

  programs = {
    feh.enable = true;
    obs-studio.enable = true;
    man.enable = true;
    lsd.enable = true;
    bat.enable = true;
  };

}
