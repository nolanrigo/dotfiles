{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {

  networking = {
    hosts = {
      "127.0.0.1" = [
        "beremote.lan"
        "auth.beremote.lan"
        "api.beremote.lan"
      ];
    };
  };

  services.nghttpx = {
    enable = true;

    frontends = [
      {
        params = {
          tls = "no-tls";
        };
        server = {
          host = "*";
          port = 80;
        };
      }
      {
        params = {
          tls = "no-tls";
        };
        server = {
          host = "*";
          port = 443;
        };
      }
    ];

    backends = [
      {
        patterns = ["beremote.lan"];
        server = {
          host = "127.0.0.1";
          port = 3000;
        };
      }
      {
        patterns = ["api.beremote.lan"];
        server = {
          host = "127.0.0.1";
          port = 3001;
        };
      }
      {
        patterns = ["auth.beremote.lan"];
        server = {
          host = "127.0.0.1";
          port = 3002;
        };
      }
      {
        patterns = [];
        server = {
          host = "127.0.0.1";
          port = 80;
        };
      }
    ];
  };
}

