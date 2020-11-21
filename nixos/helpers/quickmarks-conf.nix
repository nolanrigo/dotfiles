let
  inherit (builtins) getAttr attrNames concatStringsSep;
  mapAttrsToList = f: attrs: map (name: f name (getAttr name attrs)) (attrNames attrs);
in qs: concatStringsSep "\n" (mapAttrsToList (k: v: k + " " + v) qs)

