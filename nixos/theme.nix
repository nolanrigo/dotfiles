{ pkgs, config, ... }:

let
  inherit (builtins) readFile fetchGit;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  # Enable dconf
  programs.dconf.enable = true;

  home-manager.users."${params.username}" = {
    # GTK
    gtk = {
      enable = true;
      font = {
        package = pkgs.nerdfonts;
        name = "${params.fonts.sansSerif} ${toString params.fonts.size}";
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
      extraConfig = readFile "${deps.base16-xresources}/xresources/base16-${params.theme.base16-name}.Xresources";
    };
  };
}
