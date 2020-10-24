{ pkgs, config, ... }:

{
  programs.mcfly = {
    enable = true;
    keyScheme = "vim";
    enableFishIntegration = true;
  };
}

