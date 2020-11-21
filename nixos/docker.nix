{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {

  virtualisation.docker.enable = true;

  # Allow user to manage docker
  users.users."${params.username}".extraGroups = ["docker"];

  home-manager.users."${params.username}".home.packages = with pkgs; [
    docker-compose
  ];
}
