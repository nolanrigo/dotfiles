{ pkgs, config, ... }:

{
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
}
