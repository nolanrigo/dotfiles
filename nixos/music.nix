{ config, lib, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    programs.ncspot = {
      enable = true;
      settings = {
        use_nerdfont = true;
        default_keybindings = false;
        keybindings = {
          # Common
          "?" = "help";

          # Music nav
          Enter = "play";
          Space = "playpause";
          "[" = "voldown 5";
          "]" = "volup 5";
          r = "repeat";
          z = "shuffle";

          # Spotify nav
          O = "open current";
          o = "open selected";
          A = "goto album";
          a = "goto artist";
          c = "share selected";
          C = "share current";
          v = "insert";

          # ncspot nav
          Esc = "back";
          Backspace = "back";
          q = "focus queue";
          w = "focus library";
          e = "focus search";
          h = "move left 1";
          j = "move down 1";
          k = "move up 1";
          l = "move right 1";
        };
      };
    };

    programs.fish.shellAbbrs = {
      spotify = "ncspot";
    };


    home.packages = with pkgs; [
      spotify
    ];
  };
}
