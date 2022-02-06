{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      bitwarden
    ];
  };
}
