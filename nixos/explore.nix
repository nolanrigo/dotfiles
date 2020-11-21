{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    # Thunar
    home.packages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-dropbox-plugin
      xfce.thunar-volman
      xfce.tumbler
    ];

    # Autodetect removable devices
    services.udiskie.enable = true;
  };
}
