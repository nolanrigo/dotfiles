{ config, nixpkgs, ... }: let
  mappings = [
    {
      address = "app.beremote.lan";
      port = 3000;
    }
    {
      address = "api.beremote.lan";
      port = 3001;
    }
    {
      address = "auth.beremote.lan";
      port = 3002;
    }
  ];
in {
  networking = {
    hosts = {
      "127.0.0.1" = builtins.map (m: m.address) mappings;
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

    backends = (
      builtins.map (m: {
        patterns = [m.address];
        server = {
          host = "127.0.0.1";
          port = m.port;
        };
      }) mappings
    ) ++ [
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
