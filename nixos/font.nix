{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Enable font on the system
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      ubuntu_font_family
      (nerdfonts.override {
        fonts = ["FiraCode"];
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = params.fonts.default;
    };
  };

  # Font viewer
  home-manager.users."${params.username}".home.packages = with pkgs; [
    fontmatrix
  ];
}
