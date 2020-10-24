{ pkgs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FuraCode Nerd Font";
          style = "Regular";
        };
        size = 12;
      };
      # TODO/FIXME: When extraConfig exist, implement https://github.com/aaron-williamson/base16-alacritty/blob/master/colors/base16-onedark.yml from resources (as other base16 theme)
      # Or Read it from xrdb / Xresources : https://github.com/jwilm/alacritty/issues/1771
      colors = {
        primary = {
          background = "0x282c34";
          foreground = "0xabb2bf";
        };
        cursor = {
          text = "0x282c34";
          cursor = "0xabb2bf";
        };
        normal = {
          black = "0x282c34";
          red = "0xe06c75";
          green = "0x98c379";
          yellow = "0xe5c07b";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xabb2bf";
        };
        bright = {
          black = "0x545862";
          red = "0xd19a66";
          green = "0x353b45";
          yellow = "0x3e4451";
          blue = "0x565c64";
          magenta = "0xb6bdca";
          cyan = "0xbe5046";
          white = "0xc8ccd4";
        };
      };
      draw_bold_text_with_bright_colors = false;
    };
  };
  home.sessionVariables = {
    WINIT_X11_SCALE_FACTOR = 1;
  };
}
