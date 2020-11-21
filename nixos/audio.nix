
{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  # Allow user to manage audio
  users.users."${params.username}".extraGroups = ["audio"];

  home-manager.users."${params.username}" = {
    # Audio control GUI
    home.packages = with pkgs; [
      pavucontrol
    ];
    # Open pavucontrol as a popup
    xsession.windowManager.i3.config.floating.criteria = [{ class = "Pavucontrol"; }];
  };
}
