{ config, pkgs, ... }:

let
  params = import ./params.nix;
  deps = import ./dependencies.nix;
in {
  /*
    INFO: Options can be found there
    https://rycee.gitlab.io/home-manager/options.html
  */

  imports = [
    (import "${deps.home-manager params.nixos.version}/nixos")
  ];
}
