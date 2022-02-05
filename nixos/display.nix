{ config, pkgs, ... }:

let
  inherit (builtins) toString readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
  i3workspaces = import ./helpers/i3-workspaces.nix;
  exec = import ./helpers/i3-exec.nix;
in {
  # Display Manager
  services.xserver = let
    enable = true;
  in {
    enable = enable;
    desktopManager.xterm.enable = enable;
    displayManager = {
      autoLogin = {
        user = params.username;
        enable = enable;
      };
      lightdm = {
        enable = enable;
        greeter.enable = enable;
      };
    };
  };

  home-manager.users."${params.username}" = let
    lockScreen = "${pkgs.i3lock}/bin/i3lock -c 000000";
  in {
    home.packages = with pkgs; [
      xorg.xev # X event monitor
      xorg.xwininfo # X window info
    ];

    programs.fish.shellAbbrs = {
      lock = lockScreen;
    };

    # I3
    xsession = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;

          config = let
              mod = params.modifier;
          in {
            fonts = {
              names = [params.fonts.sansSerif];
              style = params.fonts.sansSerif;
              size = params.fonts.size;
            };

            window = {
              hideEdgeBorders = "smart";
              titlebar = false;
              border = 1;
            };

            floating = {
              titlebar = false;
              border = 2;
              criteria = [{ window_role = "pop-up"; }];
            };

            focus = {
              newWindow = "smart";
              followMouse = false;
              forceWrapping = false;
              mouseWarping = true;
            };

            startup = [
              {
                command = "${pkgs.hsetroot}/bin/hsetroot -solid \"$base00\"";
                always = true;
                notification = false;
              }
              {
                command = "${pkgs.psmisc}/bin/killall polybar; polybar main &";
                always = true;
                notification = false;
              }
            ];

            bars = [];

            keybindings = i3workspaces mod [
              "q" "w" "e" "r"
              "a" "s" "d" "f"
              "z" "x" "c" "v"
            ] // {
              # Kill
              "${mod}+p" = "kill";

              # Navigation
              "${mod}+h" = "focus left";
              "${mod}+j" = "focus down";
              "${mod}+k" = "focus up";
              "${mod}+l" = "focus right";

              "${mod}+Shift+h" = "move left";
              "${mod}+Shift+j" = "move down";
              "${mod}+Shift+k" = "move up";
              "${mod}+Shift+l" = "move right";

              # Output
              "${mod}+t" = "move workspace to output left";
              "${mod}+y" = "move workspace to output right";

              # Layout
              "${mod}+m" = "layout tabbed";
              "${mod}+comma" = "layout stacking";
              "${mod}+period" = "layout toggle split";

              # Split
              "${mod}+b" = "split h";
              "${mod}+n" = "split v";

              # Fullscreen
              "${mod}+u" = "fullscreen toggle";
              "${mod}+i" = "focus parent";
              "${mod}+o" = "focus child";

              # Floating
              "${mod}+Shift+space" = "floating toggle";
              "${mod}+space" = "focus mode_toggle";

              # Mode
              "${mod}+g" = "mode 类";
              "${mod}+Delete" = "mode ";

              # Media
              XF86AudioRaiseVolume = exec "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl up";
              XF86AudioLowerVolume = exec "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl down";
              XF86AudioMute = exec "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute";
              XF86AudioMicMute = exec "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute-input";
              XF86AudioPlay = exec "${pkgs.playerctl}/bin/playerctl play-pause";
              XF86AudioPause = exec "${pkgs.playerctl}/bin/playerctl play-pause";
              XF86AudioNext = exec "${pkgs.playerctl}/bin/playerctl next";
              XF86AudioPrev = exec "${pkgs.playerctl}/bin/playerctl previous";

              XF86MonBrightnessUp = exec "${pkgs.brightnessctl}/bin/brightnessctl s +5%";
              XF86MonBrightnessDown = exec "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
            };

            colors = {
              background = "$base07";
              focused = {
                border = "$base05";
                background = "$base0D";
                text = "$base00";
                indicator = "$base0D";
                childBorder = "$base0D";
              };
              focusedInactive = {
                border = "$base01";
                background = "$base01";
                text = "$base05";
                indicator = "$base03";
                childBorder = "$base01";
              };
              unfocused = {
                border = "$base01";
                background = "$base00";
                text = "$base05";
                indicator = "$base01";
                childBorder = "$base01";
              };
              urgent = {
                border = "$base08";
                background = "$base08";
                text = "$base00";
                indicator = "$base08";
                childBorder = "$base08";
              };
              placeholder = {
                border = "$base00";
                background = "$base00";
                text = "$base05";
                indicator = "$base00";
                childBorder = "$base00";
              };
            };

            modes = {
              "类" = rec {
                h = "resize shrink width 10 px or 10 ppt";
                "${mod}+h" = h;

                j = "resize grow height 10 px or 10 ppt";
                "${mod}+j" = j;

                k = "resize shrink height 10 px or 10 ppt";
                "${mod}+k" = k;

                l = "resize grow width 10 px or 10 ppt";
                "${mod}+l" = l;

                Escape = "mode default";
              };
              "" = rec {
                BackSpace = "${Escape}; ${exec lockScreen}";
                Home = "${Escape}; ${exec "reboot"}";
                End = "${Escape}; ${exec "shutdown now"}";

                "${mod}+BackSpace" = BackSpace;
                "${mod}+Home" = Home;
                "${mod}+End" = End;

                Escape = "mode default";
              };
            };
          };

          extraConfig = ''
            ${exec "i3-msg workspace q"}

            ${readFile "${deps.base16-i3}/colors/base16-${params.theme.base16-name}.config"}
          '';
        };
      };
    };

    # TODO: replace by i3status-rust
    services.polybar = let
      xrdb = color: "\${xrdb:${color}}";
    in {
      enable = false;
      script = "";
      package = pkgs.polybar.override {
        pulseSupport = true;
      };
      # INFO: try settings instead, same than config but nix friendly
      config = {
        "global/wm" = {
          margin-bottom = 0;
          margin-top = 0;
        };
        "bar/main" = {
          modules-left = "date blank blank title";
          modules-center = "";
          modules-right = "memory pipe cpu pipe audio pipe battery";
          width = "100%";
          height = "30";
          background = xrdb "color0";
          foreground = xrdb "color7";
          border-bottom-size = 0;
          border-color = xrdb "color4";
          font-0 = "${params.fonts.monospace}:size=${toString (params.fonts.size * 0.80)};1";
          tray-position = "right";
          tray-maxsize = 20;
          padding-left = 1;
          padding-right = 1;
        };
        "module/pipe" = {
          type = "custom/text";
          content = " | ";
        };
        "module/blank" = {
          type = "custom/text";
          content = " ";
        };
        "module/date" = {
          type = "internal/date";
          interval = 1;
          time = "%H:%M:%S";
          time-alt = "%d.%m.%Y";
          format = "<label>";
          format-foreground = xrdb "color4";
          label = "%time%";
        };
        "module/title" = {
          type = "internal/xwindow";
        };
        "module/battery" = {
          type = "internal/battery";
          full-at = 98;
          battery = "BAT0";
          adapter = "ADP1";
          poll-interval = 5;
          time-format = "%H:%M";
          format-charging = "<label-charging>";
          format-discharging = "<label-discharging>";
          label-full = " %percentage%%";
          label-charging = " %percentage%%";
          label-discharging = " %percentage%%";
        };
        "module/audio" = {
          type = "custom/script";
          tail = true;
          exec = "${deps.polybar-pulseaudio-control}/pulseaudio-control.bash"
            + " --icons-volume ' , '"
            + " --icon-muted ' '"
            + " --sink-nicknames-from 'device.description'"
            + " --sink-nickname 'alsa_output.usb-Samson_Technologies_Samson_GoMic-00.analog-stereo:GoMic'"
            + " --sink-nickname 'alsa_output.pci-0000_00_1f.3.analog-stereo:Builtin'"
            + " --sink-nickname 'bluez_sink.04_52_C7_F1_8F_B5.a2dp_sink:Q35'"
            + " listen";
          # --sink-blacklist
          click-left = "${deps.polybar-pulseaudio-control}/pulseaudio-control.bash togmute";
          click-middle = "${deps.polybar-pulseaudio-control}/pulseaudio-control.bash next-sink";
          scroll-up = "${deps.polybar-pulseaudio-control}/pulseaudio-control.bash --volume-max 130 up";
          scroll-down = "${deps.polybar-pulseaudio-control}/pulseaudio-control.bash --volume-max 130 down";
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          format = "<label>";
          label = " %percentage%%";
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format = "<label>";
          label = " %percentage_used%%";
        };
      };
    };

    # Monitors
    programs.autorandr = let
      monitors = {
        rog = "00ffffffffffff0006b3e017bb7701000a1f0104a52616783ba335a6534a9c27105054bfef00d1cf818081c0814081009500b300714f0cdf80a070384040304035007ed71000001e023a801871382d40582c45007ed71000001e000000fc00415355532058473137410a2020000000fd0030f0ffff3c010a2020202020200157020330f14c0103051404131f120211903f2309170783010000e200d565030c0010006d1a0000020130f0000000000000023a80d072382d40102c96807ed710000018047480d072382d40102c45807ed71000001e0474801871382d40582c45007ed71000001e2982805070384d400820f80c7ed71000001a00000000000000f2";
      };
      screens = {
        dp2 = "DP-2";
        dp3 = "DP-3";
        dp4 = "DP-4";
        dp5 = "DP-5";
      };
    in {
      enable = true;
      hooks = {
        postswitch = {
          i3 = "${pkgs.i3}/bin/i3-msg restart";
        };
      };
      profiles = {
        default = {
          fingerprint = {
            "${screens.dp3}" = monitors.rog;
            "${screens.dp4}" = monitors.rog;
          };
          config = {
            "${screens.dp2}".enable = false;
            "${screens.dp3}" = {
              enable = true;
              position = "1920x0";
              mode = "1920x1080";
              rate = "120";
            };
            "${screens.dp4}" = {
              enable = true;
              position = "0x0";
              mode = "1920x1080";
              rate = "120";
            };
            "${screens.dp5}".enable = false;
          };
        };
      };
    };
  };
}
