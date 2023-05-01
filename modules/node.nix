{ config, pkgs, ... }: {
  home-manager.users."${config.user.name}" = {
    home.file.".npm-init.js" = {
      text = ''
        module.exports = {
          version: '0.1.0',
          license: 'WTFPL',
          author: {
            email: '${config.user.email}',
            name: '${config.user.display}',
          },
        };
      '';
    };

    programs.fish.shellAbbrs = {
      # Npm
      ni = "npm i";
      nci = "npm ci";
      nid = "npm i -D";
      nun = "npm un";
      ncu = "npx npm-check-updates -u";
      ycu = "yarn upgrade-interactive --latest";
      npkill = "npx npkill";

      # Yarn
      y = "yarn";
      ya = "yarn add";
      yad = "yarn add --dev";
      yr = "yarn remove";
    };
  };
}
