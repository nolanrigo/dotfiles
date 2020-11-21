{ config, pkgs, ... }:

let
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  imports = [
    (import "${deps.home-manager params.nixos.version}/nixos")
  ];
}
