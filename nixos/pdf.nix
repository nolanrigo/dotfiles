{ config, pkgs, ... }:

let
  inherit (builtins) readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  home-manager.users."${params.username}" = {
    programs.zathura = {
      enable = true;
      options = {
        first-page-column = "1:1";
        smooth-scroll = true;
        statusbar-home-tilde = true;
        window-title-home-tilde = true;
        statusbar-basename = true;
        window-title-basename = true;
        selection-clipboard = "clipboard";
      };
      extraConfig = readFile "${deps.base16-zathura}/build_schemes/colors/base16-${params.theme.base16-name}.config";
    };
  };
}

