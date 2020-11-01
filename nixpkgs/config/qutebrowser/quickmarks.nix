{ ... }:

let
  inherit (builtins) getAttr attrNames;
  mapAttrsToList = f: attrs: map (name: f name (getAttr name attrs)) (attrNames attrs);
in {
  attrsToConfigLines = mapAttrsToList (key: value: key + " " + value);
}
