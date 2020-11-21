{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
}
