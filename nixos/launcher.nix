{ config, pkgs, ... }:

let
  inherit (builtins) fetchGit readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
  exec = import ./helpers/i3-exec.nix;
in {

  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      # xclip & xsel are dependencies to rofi emoji
      xclip
      xsel
      rbw
    ];


    programs.rofi = {
      enable = true;
      extraConfig = {};
      # extraConfig = ''
      #   modi: "window,run,ssh,drun"
      # '';

      plugins = with pkgs; [
        rofi-calc
        # rofi-vpn
        # rofi-rbw
        # rofi-systemd
        # rofi-power-menu
        # rofi-pulse-select
      ];

      terminal = "alacritty";
      theme = "${deps.base16-rofi}/themes/base16-${params.theme.base16-name}.rasi";
    };

    xsession.windowManager.i3.config.keybindings = let
      mod = params.modifier;
    in {
      "${mod}+apostrophe" = exec "rofi -modi drun -show drun";
      "${mod}+Shift+apostrophe" = exec "rofi -modi 'emoji:${deps.rofi-emoji}/rofiemoji.sh' -show emoji";
      "${mod}+Shift+period" = exec "rofi -modi calc -show calc";
    };
  };
}
