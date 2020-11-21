{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    # Man
    programs = {
      man.enable = true;
    };

    # tldr
    home.packages = with pkgs; [
      tealdeer
    ];
  };
}
