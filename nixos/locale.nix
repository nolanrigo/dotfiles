{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  time.timeZone = params.timeZone;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
}
