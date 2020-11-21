{ config, pkgs, ... }:

let
  params = import ./params.nix;
  exec = import ./helpers/i3-exec.nix;
in {
  home-manager.users."${params.username}" = {
    services.clipmenu.enable = true;

    home.packages = with pkgs; [
      xclip
    ];

    home.sessionVariables = {
      # Lunch clipmenu as rofi
      CM_LAUNCHER = "rofi";
    };

    # Add copy/paste as fish abbrs
    programs.fish.shellAbbrs = {
      copy = "xclip -selection clipboard";
      paste = "xclip -o -selection clipboard";
    };

    # Add keybindings to i3
    xsession.windowManager.i3.config.keybindings = let
      mod = params.modifier;
    in {
      "${mod}+Shift+slash" = exec "clipmenu";
    };
  };
}
