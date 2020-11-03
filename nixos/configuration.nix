{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system = {
    stateVersion = "20.09";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = https://nixos.org/channels/nixos-20.03;
    };
  };

  networking = {
    hostName = "earth";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
    hosts = {
      "127.0.0.1" = [];
    };
  };

  time.timeZone = "Europe/Paris";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.useOSProber = true;
  };

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
        extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
      };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };

  sound.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    mkpasswd
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      systemWide = true;
      package = pkgs.pulseaudioFull;
      #
      # extraModules = with pkgs; [
      #   pulseaudio-modules-bt
      # ];
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = true;
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
    };
    avahi.enable = true;
    blueman.enable = true;
    dbus.packages = with pkgs; [ blueman ]; # FIXTHAT: https://github.com/rycee/home-manager/issues/84
    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
      exportConfiguration = true;
      # Mouse
      libinput = {
        enable = true;
        tapping = false;
        tappingDragLock = false;
        accelProfile = "flat";
      };
      config = ''
        Section "InputClass"
          Identifier "MX Vertical Mouse"
          Driver "libinput"
          MatchIsPointer "on"
          Option "AccelProfile" "flat"
          Option "AccelSpeed" "0"
        EndSection
      '';
      # Keyboard
      layout = "us";
      xkbVariant = "altgr-intl";
      desktopManager.xterm.enable = true; # INFO: When disable it makes failing the greeting login
      displayManager.lightdm = {
        enable = true;
        # background = "dark";
        greeter.enable = true;
        # greeter.enable = false;
        # autoLogin = {
        #   enable = true;
        #   user = "nolan";
        # };
      };
    };
  };

  virtualisation.docker.enable = true;
}
