{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Enable geoclue service
  services.geoclue2.enable = true;

  # Activate redshift effect the sun goes down
  home-manager.users."${params.username}".services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
}
