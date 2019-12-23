{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = false;
  };
}
