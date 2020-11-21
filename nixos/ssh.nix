{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}".programs.ssh.enable = true;
}
