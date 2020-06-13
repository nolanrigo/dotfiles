{ pkgs, config, ... }:

{
  programs.pazi = {
    enable = true;
    enableFishIntegration = true;
  };
}
