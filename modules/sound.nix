{ config, pkgs, ... }: {
  security = {
    rtkit.enable = true;
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  home-manager.users.${config.user.name} = { };
}
