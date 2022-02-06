{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    # Ranger
    home.packages = with pkgs; [
      ranger
      mediainfo # for viewing information about media files
      jq # for JSON files
      odt2txt # for OpenDocument text files (odt, ods, odp and sxw)
      poppler_utils # for textual pdf previews, "pdftoppm" to preview as image
      bat # for syntax highlighting of code
    ];

    programs.fish.shellAbbrs.r = "ranger";
    home.sessionVariables.PAGER = "more";

    xdg.configFile."ranger/rc.conf" = {
      text = '''';
    };

    # Autodetect removable devices
    services.udiskie.enable = true;
  };
}
