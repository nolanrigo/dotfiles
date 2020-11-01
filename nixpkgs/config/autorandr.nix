{ pkgs, config, ... }:

# `xrandr --properties` to have access to monitors data

let
  monitors = {
    builtin = "00ffffffffffff0009e5db0700000000011c0104a51f1178027d50a657529f27125054000000010101010101010101010101010101013a3880de703828403020360035ae1000001afb2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a0043";
    taras = "00ffffffffffff004c2d980f51575743081e0104b53c22783a8bb4a9544697221f4c5dbfef80714f810081c081809500a9c0b300010122e50050a0a067500820f80c56502100001a000000fd0032901ee13b000a202020202020000000fc004c5332375237350a2020202020000000ff0048345a4e3230303035300a2020012e02030bb146901f04130312565e00a0a0a029503020350056502100001a023a801871382d40582c450056502100001e5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000021";
  };
in {
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        i3 = "${pkgs.i3}/bin/i3-msg restart";
      };
    };
    profiles = {
      nomade = {
        fingerprint = {
          eDP1 = monitors.builtin;
        };
        config = {
          DP1.enable = false;
          DP2.enable = false;
          HDMI1.enable = false;
          VIRTUAL1.enable = false;
          eDP1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "60";
            position = "0x0";
          };
        };
      };
      thorigny = {
        fingerprint = {
          HDMI1 = monitors.taras;
        };
        config = {
          eDP1.enable = false;
          DP1.enable = false;
          DP2.enable = false;
          VIRTUAL1.enable = false;
          HDMI1 = {
            enable = true;
            primary = true;
            mode = "2560x1440";
            rate = "60";
            position = "0x0";
          };
        };
      };
    };
  };
}
