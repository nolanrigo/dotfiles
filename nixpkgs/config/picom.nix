{ pkgs, config, ... }:

{
  services.picom = {
    enable = true;
    blur = true;
    fade = false;
    shadow = false;
  };
}
