{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
      size = "32x32";
    };
    settings = {
      global = {
        geometry = "400x50-0+0";
        format = "<b>%s</b>\n%b";
        allow_markup = "yes";
      };
    };
  };
}
