{ config, pkgs, ... }:

let
  params = import ./params.nix;
  exec = import ./helpers/i3-exec.nix;
in {
  home-manager.users."${params.username}" = {
    # Terminal Emulator
    programs.alacritty = {
      enable = true;
      # TODO: Import colors, and drawtruc
      settings = {
        font.size = params.fonts.size;
        colors = params.theme.colors;
        draw_bold_text_with_bright_colors = false;
      };
    };
    home.sessionVariables = {
      WINIT_X11_SCALE_FACTOR = 1;
    };

    # Fish
    programs.fish = {
      enable = true;
      shellAbbrs = {
        # System
        emd = "glow";
        epdf = "zathura";
        eimg = "qview";

        nrs = "sudo nixos-rebuild switch";
        nrsu = "sudo nixos-rebuild switch --upgrade";
        nrsi = "sudo nixos-rebuild switch; i3-msg restart";
        ngd = "sudo nix-collect-garbage -d";
        nip = "nix-shell -p";
        psgrep = "ps -ax | grep";
        rf = "rm -rf";
      };

      loginShellInit = "";

      interactiveShellInit = ''
        set fish_greeting
      '';

      shellInit = let
        shellDotNix = ''
          with import <nixpkgs> {};

          stdenv.mkDerivation {
            name = \"env\";
            buildInputs = [
            ];
            ENV_VARIABLE = \"VALUE\";
          }
        '';
      in ''
        fish_vi_key_bindings

        function nixify --description 'Shell function to quickly setup nix + direnv in a new project'
          if test ! -e ./.envrc
            echo "use nix" > ./.envrc
            direnv allow
          end
          if test ! -e ./shell.nix
            echo "${shellDotNix}" > ./shell.nix
            $EDITOR ./shell.nix
          end
        end
      '';
    };

    # Starship
    programs.starship = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        line_break.disabled = false;
        directory.truncate_to_repo = true;
      };
    };

    # Pazi
    programs.pazi = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = true;
    };

    # McFly
    programs.mcfly = {
      enable = true;
      keyScheme = "vim";
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = true;
    };

    # Direnv
    programs.direnv = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = true;
    };

    # Add keybindings to i3
    xsession.windowManager.i3.config.keybindings = let
      mod = params.modifier;
    in {
      "${mod}+Return" = exec "alacritty";
    };
  };
}
