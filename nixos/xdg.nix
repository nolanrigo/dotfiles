{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}".xdg = {
    enable = true;
    userDirs.enable = true;
  };
}
