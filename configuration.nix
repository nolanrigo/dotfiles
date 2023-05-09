{ config, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    <home-manager/nixos>
    ./config.nix
    ./packages.nix
    ./modules/dunst.nix
    ./modules/qutebrowser.nix
    ./modules/brave.nix
    ./modules/discord.nix
    ./modules/i3.nix
    ./modules/bluetooth.nix
    ./modules/sound.nix
    ./modules/rofi.nix
    ./modules/zathura.nix
    ./modules/node.nix
    ./modules/localhost.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/keyboard.nix
    ./modules/vpn.nix
  ];

  users.users.${config.user.name} = {
    isNormalUser = true;
    home = "/home/${config.user.name}";
    description = config.user.display;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "camera"
      "lp"
      "scanner"
      "docker"
    ];
  };

  system = {
    stateVersion = config.stateVersion;
    autoUpgrade.enable = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  virtualisation.docker.enable = true;

  fileSystems = {
    "/" = { fsType = "ext4"; device = "/dev/disk/by-label/nixos"; };
    "/boot/efi" = { fsType = "vfat"; device = "/dev/disk/by-label/BOOT"; };
    "/windows" = { fsType = "ntfs"; device = "/dev/nvme0n1p5"; options = ["rw" "uid=1000"]; };
    # "/usb" = { device = "/dev/sda2"; options = ["rw" "uid=1000"]; };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  boot = {
    supportedFilesystems = ["ntfs"];
    # kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
      timeout = 5;
    };
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    kernel = {
      sysctl."wm.swap" = 0;
    };
    extraModulePackages = [ ];
  };

  networking = {
    hostName = config.host.name;
    networkmanager.enable = true;

    nameservers = [
      "208.67.222.222"
      "208.67.220.220"
    ];
  };

  powerManagement.cpuFreqGovernor = "powersave"; # "ondemande" "powersave" "performance"

  security = {
    sudo.wheelNeedsPassword = false;
  };

  time = {
    timeZone = config.time.zone;
    hardwareClockInLocalTime = true; # Make time compatible with Windows
  };

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_TIME = "fr_CH.UTF-8";
      LC_MONETARY = "fr_CH.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      vim
      wget
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      ubuntu_font_family
    ];
    fontconfig = {
      enable = true;
      defaultFonts = let
        font = "Ubuntu";
      in {
        emoji = [font];
        serif = [font];
        sansSerif = [font];
        monospace = [font];
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "modesettings" ]; #
      dpi = 96; #
      exportConfiguration = true; #
    };

    printing = {
      enable = true;
      webInterface = true;
      browsing = true;
    };

    avahi.enable = true;
  };

  programs = {
    fish.enable = true;
    nm-applet.enable = true;
    dconf.enable = true;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.${config.user.name} = {

      home = {
        stateVersion = config.stateVersion;
        username = config.user.name;
        homeDirectory = "/home/${config.user.name}";

        sessionVariables = {
          # VAR = "VAL";
          TERMINAL = "kitty";
          EDITOR = "nvim";
          VISUAL = "nvim";
          BROWSER = "qutebrowser";
          PAGER = "more";
        };
      };

      manual = {
        html.enable = false;
        manpages.enable = false;
      };

      dconf.settings = { }; # Settings to write to the dconf configuration system. 

      editorconfig = {
        enable = true;
        settings = {
          "*" = {
            charset = "utf-8";
            end_of_line = "lf";
            trim_trailine_whitespace = true;
            insert_final_newline = true;
            max_line_width = 80;
            indent_style = "space";
            indent_size = 2;
          };
        };
      };

      fonts.fontconfig.enable = true;

      programs = {
        ssh.enable = true;
        home-manager.enable = true;

        aria2.enable = true;

        autojump = {
          enable = true;
          enableFishIntegration = false;
        };

        bat.enable = true;

        bottom.enable = true;

        # broot.enable = true;

        dircolors = {
          enable = true;
          enableFishIntegration = true;
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
          # enableFishIntegration = true;
        };

        exa = {
          enable = true;
          enableAliases = true;
        };

        feh.enable = true;

        fish = {
          enable = true;
          loginShellInit = "";
          shellInit = ''
            fish_vi_key_bindings
          '';
          interactiveShellInit = ''
            set fish_greeting
          '';
          plugins = [ ];
          shellAliases = { };
          shellAbbrs = rec {
            # Nixos
            nrs = "sudo nixos-rebuild switch";
            nrsi = "sudo nixos-rebuild switch; i3-msg restart";
            nrsu = "sudo nixos-rebuild switch --upgrade";
            nip = "nix-shell -p";
            psgrep = "ps -ax | rg";

            # git
            ga = "git add";

            # Video/Image/Document viewer
            # TODO: replace by `xdg-open` `open README.md` would open glow
            e = "nvim";
            emd = "glow -p";
            epdf = "zathura";
            eimg = "feh";

            # Files
            rf = "rm -rf";
            cpr = "cp -R";

            # Terminal
            l = "exa -al --icons --git --group-directories-first";
            ls = l;
            ltree = "exa -al --git --icons --tree --group-directories-first";
            cat = "bat";
            find = "fd";
            ps = "procs";
            sed = "sd";
            grep = "rg";
            rgf = "rg -F";
            rgfl = "rg --files-with-matches -F";
            youtubedl = "youtube-dl --format bestvideo+bestaudio";
            twitchdl = "youtube-dl --format best -o \"%(id)s.%(ext)s\"";
            t = "date";
            top = "btm";
            htop = "btm";
            j = "just";

            # Others
            copy = "xclip -selection clipboard";
            paste = "xclip -o -selection clipboard";
            download = "aria2";

            # Vpn
            von = "nmcli con up";
            voff = "nmcli con down";

            # Bluetooth
            bon = "bluetoothctl power on";
            boff = "bluetoothctl power off";
            bapon = "bluetoothctl connect 60:BE:C4:6C:79:67";
            bapoff = "bluetoothctl disconnect 60:BE:C4:6C:79:67";
            bapre = "boff; bon; bapon";
          };
          functions = {
            gitignore = "curl -sL https://www.gitignore.io/api/$argv";
            nixify =
              let
                shellDotNix = ''
                  with import <nixpkgs> {};
                  stdenv.mkDerivation {
                    name = \"env\";
                    buildInputs = [
                    ];
                    ENV_VARIABLE = \"VALUE\";
                  }
                '';
              in ''
                if test ! -e ./.envrc
                  echo "use nix" > ./.envrc
                  direnv allow
                end
                if test ! -e ./shell.nix
                  echo "${shellDotNix}" > ./shell.nix
                  $EDITOR ./shell.nix
                end
              '';
          };
        };

        jq.enable = true;

        kitty = {
          enable = true;
          font = {
            name = "FiraCode Nerd Font";
            size = 10;
          };
          settings = {
            enable_audio_bell = "no";
            disabled_ligatures = "never";
            confirm_os_window_close = 0;
          };
          keybindings = {
            "ctrl+c" = "copy_or_interrupt";
            "ctrl+v" = "paste_from_clipboard";
          };
          theme = "Dracula";
        };

        less.enable = true;
        lesspipe.enable = true;

        lf.enable = true;

        mcfly = {
          enable = true;
          enableFishIntegration = true;
        };

        navi = {
          enable = true;
          enableFishIntegration = true;
        };

        obs-studio = {
          enable = true;
          plugins = [ ];
        };

        pazi = {
          enable = true;
          enableFishIntegration = true;
        };

        # SEE: SCMPUFF

        starship = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            add_newline = true;
            line_break.truncate_to_repo = true;
            gcloud.disabled = true;
            time.disabled = false;

            # Colors
            aws.style = "bold #ffb86c";
            cmd_duration.style = "bold #f1fa8c";
            directory.style = "bold #50fa7b";
            hostname.style = "bold #ff5555";
            git_branch.style = "bold #ff79c6";
            git_status.style = "bold #ff5555";
            username = {
              format = "[$user]($style) on ";
              style_user = "bold #bd93f9";
            };
            character = {
              success_symbol = "[λ](bold #f8f8f2)";
              error_symbol = "[λ](bold #ff5555)";
            };
          };
        };

        tealdeer.enable = true;

        watson = {
          enable = true;
          enableFishIntegration = true;
        };

        zathura = {
          enable = true;
        };
      };

      services = {
        dropbox.enable = true;

        flameshot = {
          enable = true;
          settings = {}; # TODO: 
        };

        xsettingsd = {
          enable = true;
          settings = {};
        };
      };
    };
  };
}
