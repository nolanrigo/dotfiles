{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./services/dropbox.nix
  ];

  system = {
    stateVersion = "19.09";
    autoUpgrade.enable = true;
  };

  networking.hostName = "earth";

  time.timeZone = "Europe/Paris";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  users = {
    mutableUsers = false;
    users = {
      nolan = {
        description = "Nolan Rigo";
        isNormalUser = true;
        uid = 1000;
        shell = pkgs.fish;
        home = "/home/nolan";
        hashedPassword = "$6$c8tydkzzdHLfjan$2YB01HDIawthnPisIN/DgSzMPsZxiUDO7SCbcx3FQRuqhFIZySiWGMzckqmUJcflor2plAtCA7bbaq2iSsJI/0";
        extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" ];
      };
    };
  };

  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      joypixels
      nerdfonts
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    mkpasswd
  ];

  hardware = {
    # enableAllFirmware = true;
    # cpu.intel.updateMicrocode = true; # Activate on Thinkpad
    #
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      extraConfig = "
        [General]
        Enable=Source,Sink,Media,Socket
      ";
    };

    pulseaudio = {
      enable = true;
      extraModules = with pkgs; [
        pulseaudio-modules-bt
      ];
      package = pkgs.pulseaudioFull;
      support32Bit = true;

      daemon.config = {
        default-sample-format = "float32le";
        default-sample-rate = 48000;
        alternate-sample-rate = 44100;
        default-sample-channels = 2;
        default-channel-map = "front-left,front-right";
        default-fragments = 2;
        default-fragment-size-msec = 125;
        resample-method = "soxr-vhq";
        enable-lfe-remixing = "no";
        high-priority = "yes";
        nice-level = -11;
        realtime-scheduling = "yes";
        realtime-priority = 9;
        rlimit-rtprio = 9;
        daemonize = "no";
      };
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    geoclue2.enable = true;
    locate.enable = true;
    upower.enable = true;
    mopidy = {
      enable = true;
      extensionPackages = with pkgs; [ mopidy-spotify ];
    };
    printing = {
      enable = true;
      browsing = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        brlaser
        brgenml1lpr
        brgenml1cupswrapper

      ];
    };
    avahi.enable = true;
    xserver = {
      enable = true;
      exportConfiguration = true;
      multitouch.enable = true;
      libinput = {
        enable = true;
        tapping = false;
        tappingDragLock = false;
      };
      displayManager.lightdm = {
        enable = true;
        background = "dark";
        greeter.enable = true;
        # greeter.enable = false;
        # autoLogin = {
        #   enable = true;
        #   user = "nolan";
        # };
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
