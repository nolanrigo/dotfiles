{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    browsing = true;
  };
}
