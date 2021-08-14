{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {

  virtualisation.docker.enable = true;

  # Allow user to manage docker
  users.users."${params.username}".extraGroups = ["docker"];

  home-manager.users."${params.username}" = {
    home.packages = with pkgs; [
      docker-compose
    ];

    programs.fish.shellAbbrs = {
      # Docker compose
      dcu = "docker-compose up";
      dcud = "docker-compose up -d";
      dcd = "docker-compose down";
      dcdr = "docker-compose down --rmi all --volumes";
    };
  };
}
