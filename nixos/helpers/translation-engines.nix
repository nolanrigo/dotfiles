let
  inherit (builtins) map concatLists listToAttrs;
  tran = f: t: [
    { name = "${f}${t}"; value = "https://www.deepl.com/translator#${f}/${t}/{}"; }
    { name = "g${f}${t}"; value = "https://translate.google.com#${f}/${t}/{}"; }
  ];
in ls: listToAttrs (concatLists (concatLists (map (x: map (y: tran x y) ls) ls)))
