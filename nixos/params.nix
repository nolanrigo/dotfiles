{
  modifier = "Mod1";
  name = "nuc-nixos";
  username = "nolan";
  fullname = "Nolan Rigo";
  email = "nolan@rigo.dev";
  password = "$6$c8tydkzzdHLfjan$2YB01HDIawthnPisIN/DgSzMPsZxiUDO7SCbcx3FQRuqhFIZySiWGMzckqmUJcflor2plAtCA7bbaq2iSsJI/0";
  timeZone = "Europe/Paris";
  nixos = {
    version = "22.05";
  };
  networkInterfaces = [
    "enp89s0"   # Ethernet
    "wlp0s20f3" # Wireless
  ];
  localDomains = [
    # Deny
    # "twitch.tv"
    "20min.ch"
    "20minutes.fr"
    "lematin.ch"
    "koreus.com"
    "nokenny.co"
    "choualbox.com"
    "9gag.com"
  ];
  fonts = rec {
    size = 12;

    emoji = "FiraCode Nerd Font";
    serif = "Ubuntu";
    sansSerif = "Ubuntu";
    monospace = "FiraCode Nerd Font";
  };
  theme = {
    base16-name = "onedark";
    colors = {
      primary = {
        background = "#282C34";
        foreground = "#abb2bf";
      };
      cursor = {
        text = "#282c34";
        cursor = "#abb2bf";
      };
      normal = {
        black = "#282c34";
        red = "#e06c75";
        green = "#98c379";
        yellow = "#e5c07b";
        blue = "#61afef";
        magenta = "#c678dd";
        cyan = "#56b6c2";
        white = "#abb2bf";
      };
      bright = {
        black = "#545862";
        red = "#d19a66";
        green = "#353b45";
        yellow = "#3e4451";
        blue = "#565c64";
        magenta = "#b6bdca";
        cyan = "#be5046";
        white = "#c8ccd4";
      };
    };
  };
}
