{ config, pkgs, ... }: let 
  translationEngines = ls: builtins.listToAttrs (
    builtins.concatLists (
      builtins.concatLists (
        builtins.map (
          f: builtins.map (
            t: [
              { name = "${f}${t}"; value = "https://www.deepl.com/translator#${f}/${t}/{}"; }
              { name = "g${f}${t}"; value = "https://translate.google.com#${f}/${t}/{}"; }
            ]
          ) ls
        ) ls
      )
    )
  );
in {
  home-manager.users.${config.user.name} = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
