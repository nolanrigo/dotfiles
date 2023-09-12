{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };


    home.packages = with pkgs; [
      gcc
    ];

    home.file.".config/nvim/" = {
      source = ./config;
      recursive = true;
    };
  };
}
