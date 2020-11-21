{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  users = {
    mutableUsers = false;
    users = {
      "${params.username}" = {
        description = "Nolan Rigo";
        isNormalUser = true;
        uid = 1000;
        shell = pkgs.fish;
        home = "/home/${params.username}";
        hashedPassword = params.password;
        extraGroups = [ "wheel" ];
      };
    };
  };

  # Don't need password to use sudo
  security.sudo.wheelNeedsPassword = false;
}
