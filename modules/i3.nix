{ config, pkgs, ... }: let
  backgroundColor = "#282a36";
in {
  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      displayManager = {
        autoLogin = {
          enable = config.user.autoLogin;
          user = config.user.name;
        };
        lightdm = {
          enable = true;
          # background = backgroundColor;
          greeters = {
            gtk = {
              theme = {
                name = "Dracula";
                package = pkgs.dracula-theme;
              };
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = 16;
              };
            };
          };
        };
        defaultSession = "none+i3";
      };
      desktopManager.xterm.enable = true;
      windowManager.i3.enable = true;

      # Keep the computer awake
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
    geoclue2.enable = true;
  };

  home-manager.users.${config.user.name} = {
    home = {
      pointerCursor = {
        name = "Dracula-cursors";
        package = pkgs.dracula-theme;
        size = 16;
        gtk.enable = true;
        x11.enable = true;
      };

      packages = with pkgs; [
        xdotool
      ];
    };

    gtk = {
      enable = true;
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "Ubuntu";
        size = 10;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        defaultApplications = {};
      };
      desktopEntries = {
        # Extra desktop entries
        # firefox = {
        #   name = "Firefox";
        #   genericName = "Web Browser";
        #   exec = "firefox %U";
        #   terminal = false;
        #   categories = [ "Application" "Network" "WebBrowser" ];
        #   mimeType = [ "text/html" "text/xml" ];
        # };
      };
    };

    services = {
      caffeine.enable = true;

      picom = {
        enable = false;

        # Opacity
        activeOpacity = 1.0;
        menuOpacity = 1.0;
        inactiveOpacity = 1.0;

        # Shadow
        shadow = true;
        shadowOffsets = [(-14) (-14)];
        shadowOpacity = 0.35;
        shadowExclude = [
          "name = 'noshadow'"
          "class_g = 'i3-frame'"
        ];

        # fade
        fade = true;
        fadeDelta = 8;
        fadeSteps = [0.056 0.06];

        # Others
        backend = "glx";
        vSync = true;

        settings = {
          # blur = {
          #   method = "gaussian";
          #   size = 20;
          #   deviation = 20.0;
          # };
          corner-radius = 5;
          round-borders = 5;
          rounded-corners-exclude = [
            "class_g = 'i3-frame'"
          ];
        };
      };

      redshift = {
        enable = true;
        provider = "geoclue2";
      };

      betterlockscreen.enable = true;

      udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "always"; # always | auto | never
      };

      unclutter = {
        enable = true;
        timeout = 5;
      };

      sxhkd = {
        enable = false;
        keybindings = {};
      };
    };

    xsession = {
      enable = true;
      numlock.enable = true;

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = let
          mod = "Mod4";
        in {
          modifier = mod;
          defaultWorkspace = "f";
          terminal = "kitty";
          workspaceAutoBackAndForth = false;
          workspaceLayout = "default";
          bars = [];
          assigns = {
            # Assign program to a specific workspace
          };
          startup = [
            {
	      command = "${pkgs.hsetroot}/bin/hsetroot -solid \"${backgroundColor}\"";
              always = true;
              notification = false;
            }
          ];
          colors = {
            background = "#f8f8f2";
            focused = {
              background = "#6272a4";
              border = "#6272a4";
              childBorder = "#6272a4";
              indicator = "#6272a4";
              text = "#f8f8f2";
            };
            focusedInactive = {
              border = "#44475a";
              background = "#44475a";
              text = "#f8f8f2";
              indicator = "#44475a";
              childBorder = "#44475a";
            };
            placeholder = {
              border = "#282a36";
              background = "#282a36";
              text = "#f8f8f2";
              indicator = "#282a36";
              childBorder = "#282a36";
            };
            unfocused = {
              border = "#282a36";
              background = "#282a36";
              text = "#bfbfbf";
              indicator = "#282a36";
              childBorder = "#282a36";
            };
            urgent = {
              border = "#44475a";
              background = "#ff5555";
              text = "#f8f8f2";
              indicator = "#ff5555";
              childBorder = "#ff5555";
            };
          };
          gaps = {
            outer = 0;
            inner = 0;
            smartBorders = "on"; # "on", "off", "no_gaps"
            smartGaps = false;
          };
          window = {
            hideEdgeBorders = "none"; # "none", "vertical", "horizontal", "both", "smart"
            titlebar = false;
            border = 3;
            commands = [
              # workaround for https://github.com/i3/i3/issues/5149
              {
                # criteria = { class = "XTerm"; };
                criteria = {all = true;};
                command = "border pixel 3";
              }
            ];
          };
          floating = {
            titlebar = false;
            border = 3;
            criteria = [
              { window_role = "pop-up"; }
              { class = "Pavucontrol"; }
              { class = ".blueman-manager-wrapped"; }
            ];
          };
          focus = {
            followMouse = false;
            newWindow = "smart";
            forceWrapping = false;
            mouseWarping = true;
          };
          fonts = {
            names = ["Ubuntu"];
            style = "Medium";
            size = 10.0;
          };
          keybindings = let
            exec = path: "exec --no-startup-id \"${path}\"";
            workspaces = ws: builtins.listToAttrs (builtins.concatLists (builtins.map (w: [
              { name = "${mod}+${w}"; value = "workspace ${w}"; }
              { name = "${mod}+Shift+${w}"; value = "move container to workspace ${w}"; }
            ]) ws));
          in workspaces [
            "q" "w" "e" "r"
            "a" "s" "d" "f"
            "z" "x" "c" "v"
            "1" "2" "3" "4" "5"
          ] // {
            # Kill
            "${mod}+p" = "kill";

            # Navigation
            "${mod}+h" = "focus left"; # exec "${pkgs.i3-cycle-focus}/bin/i3-cycle-focus reverse";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right"; # exec "${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";

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

            # Media
            "XF86AudioRaiseVolume" = exec "pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = exec "pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = exec "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = exec "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            "XF86AudioPlay" = exec "playerctl play-pause";
            "XF86AudioPause" = exec "playerctl play-pause";
            "XF86AudioNext" = exec "playerctl next";
            "XF86AudioPrev" = exec "playerctl previous";
            "XF86ScreenSaver" = exec "betterlockscreen --lock";
            "Print" = exec "flameshot gui";

            # Programs
            "${mod}+Return" = exec "kitty";
            "${mod}+slash" = exec "qutebrowser";
            "${mod}+Shift+slash" = exec "qutebrowser --target private-window";
            "${mod}+Shift+period" = exec "rofi -modi calc -show calc";
            "${mod}+apostrophe" = exec "rofi -modi drun -show drun -show-icons";
            "${mod}+Shift+apostrophe" = exec "rofi -modi emoji -show emoji -emoji-mode copy";

            # Mode
            "${mod}+g" = "mode 类";
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
          };
        };
      };
    };
  };
}
