{ pkgs, config, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      line_break = {
        disabled = false;
      };
      directory = {
        truncate_to_repo = true;
      };
    };
  };
}
