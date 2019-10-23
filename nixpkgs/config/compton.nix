{ pkgs, config, ... }:

{
  services.compton = {
    enable = true;
    blur = true;
    fade = false;
    shadow = false;
  };
}
