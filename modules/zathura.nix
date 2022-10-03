{ config, pkgs, ... }: let 
  theme = pkgs.fetchFromGitHub {
    name = "zathura";
    owner = "dracula";
    repo = "zathura";
    rev = "master";
    sha256 = "sha256-g6vxwPw0Q9QFJBc3d4R3ZsHnnEvU5o1f4DSuyLeN5XQ=";
  };
in {
  home-manager.users.${config.user.name} = {
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
      extraConfig = builtins.readFile "${theme}/zathurarc";
    };
  };
}
