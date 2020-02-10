{ pkgs, config, ... }:

let
  font = "FuraCode\\ Nerd\\ Font 12";
  modifier = "Mod1";
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        fonts = [ font ];

        window = {
          hideEdgeBorders = "smart";
          titlebar = false;
          border = 1;
        };

        floating = {
          titlebar = false;
          border = 2;
          criteria = [
            { window_role = "pop-up"; }
            { class = "Nm-connection-editor"; }
            { class = "Pavucontrol"; }
          ];
        };

        focus = {
          newWindow = "smart";
          followMouse = false;
          forceWrapping = false;
          mouseWarping = true;
        };

        startup = [
          {
            command = "${pkgs.xorg.xrdb}/bin/xrdb -load \"${config.home.homeDirectory}/.Xresources\"";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.hsetroot}/bin/hsetroot -solid \"$base00\"";
            always = true;
            notification = false;
          }
          {
            command = "killall .polybar-wrappe; polybar main &";
            always = true;
            notification = false;
          }
        ];

        bars = [];

        keybindings = {
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec --no-startup-id \"${pkgs.rofi}/bin/rofi -modi drun -show drun\"";
          "${modifier}+Shift+d" = "exec --no-startup-id \"rofi -modi 'emoji:${config.xdg.configHome}/rofi/rofiemoji.sh' -show emoji\"";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+c" = "split h";
          "${modifier}+v" = "split v";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+a" = "focus parent";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+6" = "workspace 6";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";
          "${modifier}+0" = "workspace 10";

          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";
          "${modifier}+Shift+6" = "move container to workspace 6";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";
          "${modifier}+Shift+0" = "move container to workspace 10";

          "${modifier}+r" = "mode 类";
          "${modifier}+Delete" = "mode ";

          "${modifier}+Shift+r" = "restart";

          XF86AudioRaiseVolume = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl up";
          XF86AudioLowerVolume = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl down";
          XF86AudioMute = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute";
          XF86AudioMicMute = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute-input";
          XF86MonBrightnessUp = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s +5%";
          XF86MonBrightnessDown = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          XF86AudioPlay = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          XF86AudioPause = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          XF86AudioNext = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          XF86AudioPrev = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
          Print = "exec --no-startup-id ${pkgs.deepin.deepin-screenshot}/bin/deepin-screenshot";

          "${modifier}+F1" = "mode ";
          "${modifier}+F2" = "mode ";
        };

        colors = {
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
          background = "$base07";
        };

        modes = {
          "类" = rec {
            h = "resize shrink width 10 px or 10 ppt";
            "${modifier}+h" = h;

            j = "resize grow height 10 px or 10 ppt";
            "${modifier}+j" = j;

            k = "resize shrink height 10 px or 10 ppt";
            "${modifier}+k" = k;

            l = "resize grow width 10 px or 10 ppt";
            "${modifier}+l" = l;

            Escape = "mode default";
          };
          "" = rec {
            BackSpace = "${Escape}; exec ${pkgs.i3lock}/bin/i3lock -c '$base00'";
            Home = "${Escape}; exec --no-startup-id reboot";
            End = "${Escape}; exec --no-startup-id  shutdown now";

            "${modifier}+BackSpace" = BackSpace;
            "${modifier}+Home" = Home;
            "${modifier}+End" = End;

            Escape = "mode default";
          };
          "" = let
            perc = n: (toString (n * 11.111)) + "%";
            g_0 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 0}";
            g_1 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 1}";
            g_2 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 2}";
            g_3 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 3}";
            g_4 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 4}";
            g_5 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 5}";
            g_6 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 6}";
            g_7 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 7}";
            g_8 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 8}";
            g_9 = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s ${perc 9}";
            increase = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s +5%";
            decrease = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          in rec {
            "1" = g_0;
            "${modifier}+1" = g_0;
            "2" = g_1;
            "${modifier}+2" = g_1;
            "3" = g_2;
            "${modifier}+3" = g_2;
            "4" = g_3;
            "${modifier}+4" = g_3;
            "5" = g_4;
            "${modifier}+5" = g_4;
            "6" = g_5;
            "${modifier}+6" = g_5;
            "7" = g_6;
            "${modifier}+7" = g_6;
            "8" = g_7;
            "${modifier}+8" = g_7;
            "9" = g_8;
            "${modifier}+9" = g_8;
            "0" = g_9;
            "${modifier}+0" = g_9;
            "j" = decrease;
            "${modifier}+j" = decrease;
            "k" = increase;
            "${modifier}+k" = decrease;

            Escape = "mode default";
          };
          "" = let
            perc = n: toString (n * 11);
            g_0 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl down 200";
            g_1 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 1}";
            g_2 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 2}";
            g_3 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 3}";
            g_4 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 4}";
            g_5 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 5}";
            g_6 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 6}";
            g_7 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 7}";
            g_8 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 8}";
            g_9 = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl set ${perc 9}";
            increase = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl up";
            decrease = "exec --no-startup-id ${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl down";
          in rec {
            "1" = g_0;
            "${modifier}+1" = g_0;
            "2" = g_1;
            "${modifier}+2" = g_1;
            "3" = g_2;
            "${modifier}+3" = g_2;
            "4" = g_3;
            "${modifier}+4" = g_3;
            "5" = g_4;
            "${modifier}+5" = g_4;
            "6" = g_5;
            "${modifier}+6" = g_5;
            "7" = g_6;
            "${modifier}+7" = g_6;
            "8" = g_7;
            "${modifier}+8" = g_7;
            "9" = g_8;
            "${modifier}+9" = g_8;
            "0" = g_9;
            "${modifier}+0" = g_9;
            "j" = decrease;
            "${modifier}+j" = decrease;
            "k" = increase;
            "${modifier}+k" = decrease;

            Escape = "mode default";
          };
        };

        gaps = {
          inner = 7;
          outer = 7;
          smartGaps = false;
        };

      };

      extraConfig = ''
        # See https://i3wm.org/docs/userguide.html#xresources
        set_from_resource $base00 i3wm.color0
        set_from_resource $base01 i3wm.color10
        set_from_resource $base02 i3wm.color11
        set_from_resource $base03 i3wm.color8
        set_from_resource $base04 i3wm.color12
        set_from_resource $base05 i3wm.color7
        set_from_resource $base06 i3wm.color13
        set_from_resource $base07 i3wm.color15
        set_from_resource $base08 i3wm.color1
        set_from_resource $base09 i3wm.color09
        set_from_resource $base0A i3wm.color3
        set_from_resource $base0B i3wm.color2
        set_from_resource $base0C i3wm.color6
        set_from_resource $base0D i3wm.color4
        set_from_resource $base0E i3wm.color5
        set_from_resource $base0F i3wm.color14
        exec --no-startup-id i3-msg workspace 1
      '';
    };
  };
}
