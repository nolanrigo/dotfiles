{ pkgs, config, ... }:

{
  # GTK
  gtk = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "3270 Nerd Font 12";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
  };

  # Cursor
  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors-white";
    size = 32;
  };

  # Colors
  xresources = {
    extraConfig = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/base16-xresources/xresources/base16-${config.home.sessionVariables.COLORTHEME}.Xresources" );
  };
}
