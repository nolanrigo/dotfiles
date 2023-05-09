{ config, pkgs, ... }: let
  theme = pkgs.fetchFromGitHub {
    name = "rofi";
    owner = "dracula";
    repo = "rofi";
    rev = "master";
    sha256 = "sha256-raoJ3ndKtpEpsN3yN4tMt5Kn1PrqVzlakeCZMETmItw=";
  };
in {
  home-manager.users.${config.user.name} = {
    programs.rofi = {
      enable = true;

      location = "top";
      yoffset = 100;

      terminal = "kitty";

      theme = "${theme}/theme/config1";
      font = "Ubuntu 11";

      plugins = with pkgs; [
        rofi-calc
        rofi-vpn
        rofi-rbw
        rofi-emoji
        rofi-bluetooth
        rofi-power-menu
        rofi-systemd
        rofi-pulse-select
      ];

    };
  };
}
