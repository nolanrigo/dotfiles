{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Enable font on the system
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [params.fonts.emoji];
        serif = [params.fonts.serif];
        sansSerif = [params.fonts.sansSerif];
        monospace = [params.fonts.monospace];
      };
    };
  };

  # Font viewer
  home-manager.users."${params.username}".home.packages = with pkgs; [
    fontmatrix
  ];
}
