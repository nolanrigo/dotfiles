{ config, pkgs, ... }: {
  home-manager.users."${config.user.name}" = let
    scripts = {
      proton-import = pkgs.writeText "protonvpn-import" ''
        #!/usr/bin/env bash

        CONFIG_PATH=$XDG_CONFIG_HOME/protonvpn/ovpn

        # Zip path from $1
        ZIP_PATH=$1
        if [ -z "$ZIP_PATH" ]; then
          echo "Usage: protonvpn-import <path to zip file>"
          exit 1
        fi

        read -s -p  "OpenVPN username: " USERNAME;
        echo "";
        read -s -p  "OpenVPN password: " PASSWORD;
        echo "";

        # Reset from the previous import
        rm -rf $CONFIG_PATH
        for CONN in $(nmcli con show | rg protonvpn | awk '{print $1}'); do
            nmcli con delete "$CONN"
        done
        # Create new empty directory
        mkdir -p $CONFIG_PATH

        # Extraire et traiter les fichiers .ovpn
        unzip -o "$ZIP_PATH" -d $CONFIG_PATH
        for FILE in $CONFIG_PATH/*.ovpn; do
            # Importer les connexions VPN
            nmcli con import type openvpn file "$FILE"

            # Modifier le nom
            ORIGINAL_NAME=$(basename "$FILE" .ovpn)
            LANGUAGE=$(echo $ORIGINAL_NAME | sed -n 's/^\([^.]*\)\..*$/\1/p')
            NEW_NAME="protonvpn-$LANGUAGE"
            nmcli con modify "$ORIGINAL_NAME" connection.id "$NEW_NAME"

            # Set username and password for each VPN connection
            nmcli con modify "$NEW_NAME" vpn.user-name "$USERNAME"
            nmcli con modify "$NEW_NAME" +vpn.secrets "password=$PASSWORD"
        done
      '';
    };
  in {
    programs.fish.shellAbbrs = {
      protonvpn-import = "bash ${scripts.proton-import}";
    };
  };
}
