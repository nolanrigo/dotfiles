{ config, lib, pkgs, ... }:

let
  inherit (builtins) fetchGit readFile;
  params = import ./params.nix;
  toINI = lib.generators.toINI {};
in {
  home-manager.users."${params.username}" = {
    home.file.".sqitch/sqitch.conf".text = toINI {
      user = {
        name = params.fullname;
        email = params.email;
      };
    };
  };
}
