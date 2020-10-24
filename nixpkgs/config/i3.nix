{ pkgs, config, ... }:

let
  font = "FuraCode\\ Nerd\\ Font 12";
  alt = "Mod1";
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
            { class = ".blueman-manager-wrapped"; }
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
          "${alt}+q" = "workspace q";
          "${alt}+w" = "workspace w";
          "${alt}+e" = "workspace e";
          "${alt}+r" = "workspace r";
          "${alt}+a" = "workspace a";
          "${alt}+s" = "workspace s";
          "${alt}+d" = "workspace d";
          "${alt}+f" = "workspace f";
          "${alt}+z" = "workspace z";
          "${alt}+x" = "workspace x";
          "${alt}+c" = "workspace c";
          "${alt}+v" = "workspace v";

          "${alt}+Shift+q" = "move container to workspace q";
          "${alt}+Shift+w" = "move container to workspace w";
          "${alt}+Shift+e" = "move container to workspace e";
          "${alt}+Shift+r" = "move container to workspace r";
          "${alt}+Shift+a" = "move container to workspace a";
          "${alt}+Shift+s" = "move container to workspace s";
          "${alt}+Shift+d" = "move container to workspace d";
          "${alt}+Shift+f" = "move container to workspace f";
          "${alt}+Shift+z" = "move container to workspace z";
          "${alt}+Shift+x" = "move container to workspace x";
          "${alt}+Shift+c" = "move container to workspace c";
          "${alt}+Shift+v" = "move container to workspace v";
        } // {
          "${alt}+apostrophe" = "exec --no-startup-id \"rofi -modi drun -show drun\"";
          "${alt}+Shift+apostrophe" = "exec --no-startup-id \"rofi -modi 'emoji:${config.xdg.configHome}/rofi/rofiemoji.sh' -show emoji\"";
          "${alt}+Return" = "exec alacritty";
          "${alt}+slash" = "exec qutebrowser";
          "${alt}+p" = "kill";

          "${alt}+g" = "mode 类";

          "${alt}+h" = "focus left";
          "${alt}+j" = "focus down";
          "${alt}+k" = "focus up";
          "${alt}+l" = "focus right";

          "${alt}+Shift+h" = "move left";
          "${alt}+Shift+j" = "move down";
          "${alt}+Shift+k" = "move up";
          "${alt}+Shift+l" = "move right";

          "${alt}+m" = "layout tabbed";
          "${alt}+comma" = "layout toggle split";
          "${alt}+period" = "layout stacking";

          "${alt}+b" = "split h";
          "${alt}+n" = "split v";

          "${alt}+u" = "fullscreen toggle";
          "${alt}+i" = "focus parent";
          "${alt}+o" = "focus child";

          "${alt}+Shift+space" = "floating toggle";
          "${alt}+space" = "focus mode_toggle";

        "${alt}+Delete" = "mode "; # Keep the old way to shutdown my computer by laptop keyboard

        XF86AudioRaiseVolume = "exec --no-startup-id pulseaudio-ctl up";
        XF86AudioLowerVolume = "exec --no-startup-id pulseaudio-ctl down";
        XF86AudioMute = "exec --no-startup-id pulseaudio-ctl mute";
        XF86AudioMicMute = "exec --no-startup-id pulseaudio-ctl mute-input";
        XF86MonBrightnessUp = "exec --no-startup-id brightnessctl s +5%";
        XF86MonBrightnessDown = "exec --no-startup-id brightnessctl s 5%-";
        XF86AudioPlay = "exec --no-startup-id playerctl play-pause";
        XF86AudioPause = "exec --no-startup-id playerctl play-pause";
        XF86AudioNext = "exec --no-startup-id playerctl next";
        XF86AudioPrev = "exec --no-startup-id playerctl previous";
        Print = "exec --no-startup-id find_something"; # TODO: Find an other tools to take printscreen
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
          "${alt}+h" = h;

          j = "resize grow height 10 px or 10 ppt";
          "${alt}+j" = j;

          k = "resize shrink height 10 px or 10 ppt";
          "${alt}+k" = k;

          l = "resize grow width 10 px or 10 ppt";
          "${alt}+l" = l;

          Escape = "mode default";
        };
        "" = rec {
          BackSpace = "${Escape}; exec ${pkgs.i3lock}/bin/i3lock -c '$base00'";
          Home = "${Escape}; exec --no-startup-id reboot";
          End = "${Escape}; exec --no-startup-id  shutdown now";

          "${alt}+BackSpace" = BackSpace;
          "${alt}+Home" = Home;
          "${alt}+End" = End;

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
      # Remove Alt_R/AltGr from Mod1
      exec --no-startup-id ${pkgs.xorg.xmodmap}/bin/xmodmap -e 'remove Mod1 = Alt_R'

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

      exec --no-startup-id i3-msg workspace q
    '';
  };
};
}
