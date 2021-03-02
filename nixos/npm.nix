{ config, pkgs, ... }:

let
  inherit (builtins) fetchGit readFile;
  params = import ./params.nix;
  deps = import ./dependencies.nix;
  exec = import ./helpers/i3-exec.nix;
  translationEngines = import ./helpers/translation-engines.nix;
  quickmarksConf = import ./helpers/quickmarks-conf.nix;
in {
  home-manager.users."${params.username}" = {
    home.file.".npm-init.js" = {
      text = ''
        module.exports = {
          version: '0.1.0',
          license: 'WTFPL',
          author: {
            email: '${params.email}',
            name: '${params.fullname}',
          },
        };
      '';
    };
  };
}
