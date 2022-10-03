{ config, pkgs, ... }: let
  theme = pkgs.fetchFromGitHub {
    name = "dunst";
    owner = "dracula";
    repo = "dunst";
    rev = "master";
    sha256 = "sha256-+wGS06ieD80kFCIthiOh7PCUIA+xZ7+1xBMmqi8f1TE=";
  };
in {
  home-manager.users.${config.user.name} = {
    xdg.configFile."dunst/dracula" = {
      source = theme;
    };

    services = {
      dunst = {
        enable = true;
        configFile = "${theme}/dunstrc";
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
  };
}
