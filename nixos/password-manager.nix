{ config, pkgs, ... }:

let
  params = import ./params.nix;
  exec = import ./helpers/i3-exec.nix;
in {
  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      bitwarden
    ];
  };
}
