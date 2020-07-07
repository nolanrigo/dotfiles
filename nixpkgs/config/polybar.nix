{ pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
      pulseSupport = true;
    };
    script = '''';

    config = let
      var = a: "\${${a}}";
      click_i = cmd: ({
        click-left = "${cmd} &";
        click-middle = "${cmd} &";
        click-right = "${cmd} &";
      });
    in {
      "global/vm" = {
        margin-bottom = 0;
        margin-top = 0;
      };
      "color" = {
        # Active Colors
        bg = "#2f343f";
        fg = "#1C1E20";
        fg-alt = "#C4C7C5";
        mf = "#C4C7C5";
        ac = "#B4BC67";
        # Bars
        bn = "#308634";
        bm = "#E57C46";
        bd = "#E24C49";
        trans = "#00000000";
        white = "#FFFFFF";
        black = "#000000";
        # Colors
        red = "#EC7875";
        pink = "#EC6798";
        purple = "#BE78D1";
        blue = "#75A4CD";
        cyan = "#00C7DF";
        teal = "#00B19F";
        green = "#61C766";
        lime = "#B9C244";
        yellow = "#EBD369";
        amber = "#EDB83F";
        orange = "#E57C46";
        brown = "#AC8476";
        grey = "#8C8C8C";
        indigo = "#6C77BB";
        blue-gray = "#6D8895";
      };
      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = false;
        enable-click = true;
        enable-scroll = false;
        wrapping-scroll = false;
        reverse-scroll = false;
        format = "<label-state><label-mode>";
        ws-icon-0  = "q;Q";
        ws-icon-1  = "w;W";
        ws-icon-2  = "e;E";
        ws-icon-3  = "r;R";
        ws-icon-4  = "t;T";
        ws-icon-5  = "y;Y";
        ws-icon-6  = "u;U";
        ws-icon-7  = "i;I";
        ws-icon-8  = "o;O";
        ws-icon-9  = "p;P";
        ws-icon-10 = "a;A";
        ws-icon-11 = "s;S";
        ws-icon-12 = "d;D";
        ws-icon-13 = "f;F";
        ws-icon-14 = "g;G";
        ws-icon-15 = "h;H";
        ws-icon-16 = "j;J";
        ws-icon-17 = "k;K";
        ws-icon-18 = "l;L";
        ws-icon-19 = "z;Z";
        ws-icon-20 = "x;X";
        ws-icon-21 = "c;C";
        ws-icon-22 = "v;V";
        ws-icon-23 = "b;B";
        ws-icon-24 = "n;N";
        ws-icon-25 = "m;M";

        label-focused = "%icon%";
        label-focused-background = var "theme.base0D";
        label-focused-foreground = var "theme.base01";
        label-focused-underline = var "theme.base09";
        label-focused-padding = 1;
        label-unfocused = "%icon%";
        label-unfocused-background = var "theme.base02";
        label-unfocused-foreground = var "theme.base05";
        label-unfocused-underline = var "theme.base09";
        label-unfocused-padding = 1;
        label-visible = "%icon%";
        label-visible-underline = "#555555";
        label-visible-padding = 1;
        label-urgent = "%icon%";
        label-urgent-background = var "theme.base08";
        label-urgent-foreground = var "theme.base00";
        label-urgent-padding = 1;
        label-mode = "%mode%";
        label-mode-background = var "theme.base09";
        label-mode-foreground = var "theme.base00";
        label-mode-padding = 1;
      };
      "module/date_i" = {
        type = "custom/text";
        content = "";
        content-background = var "color.amber";
        content-foreground = var "color.fg";
        content-padding = 1;
      };
      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        time = "%H:%M:%S";
        time-alt = "%d.%m.%Y";
        format = "<label>";
        format-background = var "theme.base02";
        format-foreground = var "theme.base05";
        format-padding = 1;
        label = "%time%";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        sink = "alsa_output.pci-0000_12_00.3.analog-stereo";
        use-ui-max = true;
        interval = 5;
        format-volume = "<label-volume>";
        format-volume-background = var "theme.base02";
        format-volume-foreground = var "theme.base05";
        format-volume-padding = 1;
        label-muted = "---";
        format-muted-background = var "theme.base02";
        format-muted-foreground = var "color.red";
        format-muted-padding = 1;
      };
      "module/pulseaudio_i" = {
        inherit (click_i "${pkgs.pavucontrol}/bin/pavucontrol") click-left click-middle click-right;
        type = "custom/text";
        content = "";
        content-background = var "color.blue";
        content-foreground = var "color.fg";
        content-padding = 1;
      };
      "module/mpd" = {
        type = "internal/mpd";
        interval = 2;
        format-online = "<label-song> <icon-next>";
        format-online-background = var "color.mf";
        format-online-padding = 1;
        label-song =  "%artist% - %title%";
        label-song-maxlen = 20;
        label-song-ellipsis = true;
        label-offline = "MPD is offline";
        icon-play = "";
        icon-pause = "";
        icon-stop = "";
        icon-prev = "玲";
        icon-next = "怜";
      };
      "module/mpd_i" = {
        type = "internal/mpd";
        interval = 2;
        format-online = "<toggle>";
        format-online-background = var "color.red";
        format-online-padding = 1;
        icon-play = "";
        icon-pause = "";
      };
      "module/wireless" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        interval = "1.0";
        accumulate-stats = true;
        unknown-as-up = true;
        format-connected = "<label-connected>";
        format-connected-background = var "theme.base02";
        format-connected-foreground = var "theme.base05";
        format-connected-padding = 1;
        label-connected = "%essid% (%signal%%)  %downspeed% 祝 %upspeed%";
      };
      "module/wireless_i" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        interval = "1.0";
        format-connected = "<label-connected>";
        format-connected-background = var "color.purple";
        format-connected-foreground = var "color.fg";
        format-connected-padding = 1;
        label-connected = "";
      };
      "module/wired_i" = {
        type = "internal/network";
        interface = "enp0s31f6";
        interval = "1.0";
        format-connected = "<label-connected>";
        format-connected-background = var "color.purple";
        format-connected-foreground = var "color.fg";
        format-connected-padding = 1;
        label-connected = "";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format = "<label>";
        format-background = var "theme.base02";
        format-foreground = var "theme.base05";
        format-padding = 1;
        label = "%percentage%%";
      };
      "module/cpu_i" = {
        inherit (click_i "${pkgs.alacritty}/bin/alacritty --command ${pkgs.htop}/bin/htop") click-left click-middle click-right;
        type = "custom/text";
        content = "﬙";
        content-background = var "color.teal";
        content-foreground = var "color.fg";
        content-padding = 1;
      };
      "module/battery" = {
        type = "internal/battery";

        full-at = 97;

        battery = "BAT0";
        adapter = "ADP1";
        poll-interval = 2;

        time-format = "%H:%M";

        format-charging = "<label-charging>";
        format-charging-background = var "theme.base02";
        format-charging-foreground = var "theme.base05";
        format-charging-padding = 1;

        format-discharging = "<label-discharging>";
        format-discharging-background = var "theme.base02";
        format-discharging-foreground = var "theme.base05";
        format-discharging-padding = 1;

        label-full = "%percentage%%";
        label-full-background = var "theme.base02";
        label-full-foreground = var "theme.base05";
        label-full-padding = 1;

        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
      };
      "module/battery_i" = {
        type = "internal/battery";

        full-at = 99;
        battery = "BAT0";
        adapter = "ADP1";
        poll-interval = 2;

        time-format = "%H:%M";

        format-charging = "<label-charging>";
        format-charging-background = var "color.green";
        format-charging-foreground = var "color.fg";
        format-charging-padding = 1;

        format-discharging = "<ramp-capacity>";
        format-discharging-background = var "color.pink";
        format-discharging-foreground = var "color.fg";
        format-discharging-padding = 1;

        label-charging = "ﮣ";

        label-full = "";
        label-full-background = var "color.green";
        label-full-foreground = var "color.fg";
        label-full-padding = 1;

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-5 = "";
        ramp-capacity-6 = "";
        ramp-capacity-7 = "";
        ramp-capacity-8 = "";
        ramp-capacity-9 = "";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 3;
        format = "<label>";
        format-background = var "theme.base02";
        format-foreground = var "theme.base05";
        format-padding = 1;
        label = "%percentage_used%%";
      };
      "module/memory_i" = {
        type = "custom/text";
        content = "";
        content-background = var "color.brown";
        content-foreground = var "color.fg";
        content-padding = 1;
      };
      # "module/backlight" = {
        # type = "internal/xbacklight";
        # card = "auto";
        # format = "<label>";
        # format-background = var "color.mf";
        # format-foreground = var "color.fg";
        # format-padding = 1;
        # label = "%percentage%%";
      # };
      # "module/backlight_i" = {
        # type = "internal/xbacklight";
        # card = "auto";
        # format = "<ramp>";
        # format-background = var "color.lime";
        # format-foreground = var "color.fg";
        # format-padding = 1;
        # ramp-0 = "";
        # ramp-1 = "ﯧ";
        # ramp-2 = "ﯧ";
        # ramp-3 = "ﯧ";
        # ramp-4 = "ﯧ";
        # ramp-5 = "ﯧ";
        # ramp-6 = "ﯧ";
        # ramp-7 = "ﯧ";
        # ramp-8 = "ﯧ";
        # ramp-9 = "ﯧ";
      # };
      "module/separator" = {
        type = "custom/text";
        content = "|";
        content-background = var "color.trans";
        content-foreground = var "color.trans";
        content-padding = "0.5";
      };
      "bar/main" = {
        modules-left = "i3 separator wired_i wireless_i wireless";
        modules-center = "";
        modules-right = "cpu_i cpu separator memory_i memory separator battery_i battery separator pulseaudio_i pulseaudio separator date_i date";

        tray-position = "center";
        tray-maxsize = 24;

        font-0 = "FuraCode Nerd Font:size=14;4";
        width = "100%";
        height = 30;
        bottom = true;
        monitor-strict = false;
        override-redirect = false;
        fixed-center = true;
        offset-x = 0;
        offset-y = 0;
        background = var "color.trans";
        foreground = var "color.fg";
        radius-top = "0.0";
        radius-bottom = "0.0";
        border-size = 0;
        border-color = var "color.trans";
        border-bottom-size = 14;
        padding-left = 1;
        padding-right = 1;
        module-margin-left = 0;
        module-margin-right = 0;
        separator = "";
        dim-value = "1.0";
      };
    };

    extraConfig = ''
      [theme]
      base00 = ''${xrdb:color0}
      base01 = ''${xrdb:color10}
      base02 = ''${xrdb:color11}
      base03 = ''${xrdb:color8}
      base04 = ''${xrdb:color12}
      base05 = ''${xrdb:color7}
      base06 = ''${xrdb:color13}
      base07 = ''${xrdb:color15}
      base08 = ''${xrdb:color1}
      base09 = ''${xrdb:color9}
      base0A = ''${xrdb:color3}
      base0B = ''${xrdb:color2}
      base0C = ''${xrdb:color6}
      base0D = ''${xrdb:color4}
      base0E = ''${xrdb:color5}
      base0F = ''${xrdb:color14}
    '';
  };
}
