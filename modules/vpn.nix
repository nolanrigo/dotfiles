{ config, pkgs, ... }: {
  home-manager.users."${config.user.name}" = let 
    scripts = {
      proton-import = pkgs.writeText "proton-vpn-import" ''
        #!/usr/bin/env bash

        read -s -p  "OpenVPN username: " USERNAME;
        echo "";
        read -s -p  "OpenVPN password: " PASSWORD;
        echo "";

        for FILE in ~/vpns/protonvpn-*; do
          NAME=$(basename $FILE);

          # if the vpn connnection already exist, delete it
          if nmcli connection show "$NAME" &> /dev/null; then
            echo "Delete $NAME";
            nmcli connection delete "$NAME";
          fi

          # import vpn connection
          echo "Import $FILE";
          nmcli c import type openvpn file $FILE;

          # set credentials for this connection
          echo "Set username";
          nmcli c mod $NAME vpn.user-name "$USERNAME";
          echo "Set password";
          nmcli c mod $NAME vpn.secrets "password=$PASSWORD";
        done
      '';
    };
  in {
    programs.fish.shellAbbrs = {
      vpn-proton-import = "bash ${scripts.proton-import}";
    };
  };
}
