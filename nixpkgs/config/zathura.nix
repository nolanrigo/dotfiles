{ pkgs, config, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      first-page-column = "1:1";
      smooth-scroll = "true";
      #set recolor = "true";
      statusbar-home-tilde = "true";
      window-title-home-tilde = "true";
      statusbar-basename = "true";
      window-title-basename = "true";
      selection-clipboard = "clipboard";
    };
    extraConfig = builtins.readFile ("${config.home.homeDirectory}/dotfiles/resources/base16-zathura/build_schemes/base16-${config.home.sessionVariables.COLORTHEME}.config" );
  };
}
