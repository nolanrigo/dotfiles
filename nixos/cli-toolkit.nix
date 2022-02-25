{ config, pkgs, ... }:

let
  inherit (builtins) readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      exa
      sl
      fd
      procs
      sd
      ripgrep
      ripgrep-all
      broot             # Find in a folder
      zip
      unzip
      nettools
      bandwhich         # network usage
      grex              # Generate Regex
      youtube-dl
      streamlink
    ];

    programs.bat = {
      enable = true;
      config = {
        theme = params.theme.base16-name;
      };
      themes = {
        "${params.theme.base16-name}" = readFile "${deps.base16-textmate}/Themes/base16-${params.theme.base16-name}.tmTheme";
      };
    };

    # as fish abbrs
    programs.fish.shellAbbrs = rec {
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
      md = "make dev";
      mb = "make build";
      mc = "make clean";
      mt = "make test";
      youtubedl = "youtube-dl --format bestvideo+bestaudio";
      twitchdl = "youtube-dl --format best";
      t = "date";
    };

    # nix-index
    programs.nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = true;
    };
  };
}
