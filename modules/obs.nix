{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    home.packages = with pkgs; [
      obs-cli
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        waveform
        obs-tuna
        input-overlay
        obs-move-transition
        advanced-scene-switcher
      ];
    };
  };
}
