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

  networking = {
    hostName = "earth";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
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
        extraGroups = [ "wheel" "networkmanager" "docker" ];
      };
    };
  };

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
      extraModules = with pkgs; [
        pulseaudio-modules-bt
      ];
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = false;
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
    };
    avahi.enable = true;
    blueman.enable = true;
    dbus.packages = with pkgs; [ blueman ]; # FIXTHAT: https://github.com/rycee/home-manager/issues/84
    pcscd.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
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

  virtualisation.docker.enable = true;
}
