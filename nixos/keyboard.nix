{ config, pkgs, lib, ... }:

let
  params = import ./params.nix;
in {
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
    displayManager.sessionCommands = let
      kbCustomLayout = pkgs.writeText "xkb-layout" ''
        keycode 90 = eacute Eacute
        keycode 87 = ecircumflex Ecircumflex
        keycode 88 = egrave Egrave
        keycode 84 = acircumflex Acircumflex
        keycode 83 = agrave Agrave
        keycode 89 = ccedilla Ccedilla
        keycode 85 = ucircumflex Ucircumflex
        keycode 79 = ugrave Ugrave
        keycode 80 = icircumflex Icircumflex
        keycode 125 = ocircumflex Ocircumflex
      '';
    in "${pkgs.xorg.xmodmap}/bin/xmodmap ${kbCustomLayout}";
  };

  home-manager.users."${params.username}" = {
    # Activate numlock
    xsession.numlock = {
      enable = true;
    };

    /**
     * FIXME: home-manager, by default, reset keyboard when it starts
     * apply this change to keep our keyboard' updates applied
     * see: https://github.com/nix-community/home-manager/issues/543#issuecomment-481469067
     */
    systemd.user = {
      services = {
        setxkbmap.Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
      };
    };
  };
}

