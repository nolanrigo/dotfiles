{ lib, ... }: with lib; with types; {
  options = {
    stateVersion = mkOption { type = str; };
    user = mkOption {
      type = submodule {
        options = {
          name = mkOption { type = str; };
          display = mkOption { type = str; };
          email = mkOption { type = str; };
          autoLogin = mkOption { type = bool; };
        };
      };
    };
    host = mkOption {
      type = submodule {
        options = {
          name = mkOption { type = str; };
        };
      };
    };
    time = mkOption {
      type = submodule {
        options = {
          zone = mkOption { type = str; };
        };
      };
    };
    theme = mkOption {
      type = submodule {
        options = {
          background = mkOption { type = str; };
          background-alt = mkOption { type = str; };
          background-attention = mkOption { type = str; };
          border = mkOption { type = str; };
          current-line = mkOption { type = str; };
          selection = mkOption { type = str; };
          foreground = mkOption { type = str; };
          foreground-alt = mkOption { type = str; };
          foreground-attention = mkOption { type = str; };
          comment = mkOption { type = str; };
          cyan = mkOption { type = str; };
          green = mkOption { type = str; };
          orange = mkOption { type = str; };
          pink = mkOption { type = str; };
          purple = mkOption { type = str; };
          red = mkOption { type = str; };
          yellow = mkOption { type = str; };
        };
      };
    };
  };

  config = {
    stateVersion = "22.05";
    user = {
      name = "nolan";
      display = "Nolan Rigo";
      email = "nolan@rigo.dev";
      autoLogin = true;
    };
    host = {
      name = "nuc-nixos";
    };
    time = {
      zone = "Europe/Tallinn";
    };
    theme = {
      background = "#282a36";
      background-alt = "#282a36";
      background-attention = "#181920";
      border = "#282a36";
      current-line = "#44475a";
      selection = "#44475a";
      foreground = "#f8f8f2";
      foreground-alt = "#e0e0e0";
      foreground-attention = "#ffffff";
      comment = "#6272a4";
      cyan = "#8be9fd";
      green = "#50fa7b";
      orange = "#ffb86c";
      pink = "#ff79c6";
      purple = "#bd93f9";
      red = "#ff5555";
      yellow = "#f1fa8c";
    };
  };
}
