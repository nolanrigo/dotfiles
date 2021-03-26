{ config, pkgs, ... }:

let
  inherit (builtins) readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      exa
      fd
      procs
      sd
      ripgrep-all # ripgrep
      broot
      zip
      unzip
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
    };
  };
}
