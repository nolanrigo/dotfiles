{ config, pkgs, ... }:

{
  imports = [
    #
    # System
    ./hardware-configuration.nix
    ./system.nix
    ./boot.nix
    ./packages.nix
    ./network.nix
    ./gpu.nix
    ./home-manager.nix
    ./locale.nix
    ./bluetooth.nix
    ./audio.nix
    ./ssh.nix
    ./power.nix
    ./print.nix
    ./display.nix
    ./mouse.nix
    ./keyboard.nix
    ./redshift.nix
    ./xdg.nix
    ./clipboard.nix
    ./font.nix
    ./theme.nix
    #
    # User
    ./user.nix
    ./cli-toolkit.nix
    ./git.nix
    ./terminal.nix
    ./editor.nix
    ./docker.nix
    ./dropbox.nix
    ./browser.nix
    ./password-manager.nix
    ./man.nix
    ./launcher.nix
    ./explore.nix
    ./stream.nix
    ./pdf.nix
  ];

  # TODO: Move it elsewhere
  services.locate.enable = true;
}
