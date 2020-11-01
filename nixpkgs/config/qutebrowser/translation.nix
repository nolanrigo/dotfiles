{ lib, ... }:

let
  inherit (builtins) head tail length;
  inherit (lib) recursiveUpdate;
  tran = f: t: {
    "${f}${t}" = "https://www.deepl.com/translator#${f}/${t}/{}";
    "g${f}${t}" = "https://translate.google.com#${f}/${t}/{}";
  };
  tranll = f: tl: if (length tl) == 0 then {} else recursiveUpdate (tran f (head tl)) (tranll f (tail tl));
  translationEngines' = fl: tl: if (length fl) == 0 then {} else recursiveUpdate (tranll (head fl) tl) (translationEngines' (tail fl) tl);
in {
  translationEngines = l: translationEngines' l l;
}
