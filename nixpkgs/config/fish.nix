{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      # Git
      gs = "git status";
      gl = "git lg";
      ga = "git add";
      gap = "git add -p";
      gco = "git checkout";
      gcm = "git commit";
      gcmf = "git commit --fixup";
      gcma = "git commit --amend";
      grb = "git rebase";
      grbi = "git rebase -i";
      grbc = "git rebase --continue";
      grba = "git rebase --abort";
      gpl = "git pull";
      gpu = "git push";
      gpuu = "git push -u origin";
      gpuf = "git push --force";
      gpufl = "git push --force-with-lease";
      gm = "git merge";
      gss = "git stash save -u";
      gsp = "git stash pop --index";
      gsl = "git stash list";
      gsc = "git stash clear";
      gbr = "git branch -avv";
      gbrd = "git brand -d";

      # Npm
      n = "npm";
      nx = "npx";
      ni = "npm i";
      nci = "npm ci";
      nid = "npm i -D";
      nun = "npm un";
      nh = "npm home";
      nr = "npm repo";
      ncu = "npx npm-check-updates -u";

      # Yarn
      y = "yarn";
      ya = "yarn add";
      yad = "yarn add --dev";
      yr = "yarn remove";

      # System
      e = "nvim";
      emd = "glow";
      epdf = "zathura";
      eimg = "qview";
      hms = "home-manager switch";
      hmsi3 = "home-manager switch; i3-msg restart";
      nrs = "sudo nixos-rebuild switch";
      nrsu = "sudo nixos-rebuild switch --upgrade";
      psgrep = "ps -ax | grep";
      rf = "rm -rf";

      # Copy / Paste
      copy = "xclip -selection clipboard";
      paste = "xclip -o -selection clipboard";

      # Lastpass
      lpwd = "lpass show -c --password";
      lusr = "lpass show -c --username";
      lgen = "lpass generate -c (head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13) 50";
      ladd = "lpass add";
    };
    loginShellInit = ''
    '';
    interactiveShellInit = ''
      set fish_greeting
    '';
    promptInit = ''
      eval (${pkgs.starship}/bin/starship init fish)
    '';
    shellInit = ''
      fish_vi_key_bindings

      function nixify --description 'Shell function to quickly setup nix + direnv in a new project'
        if test ! -e ./.envrc
          echo "use nix" > .envrc
          direnv allow
        end
        if test ! -e shell.nix
          echo >shell.nix "\
with import <nixpkgs> {};

stdenv.mkDerivation {
  name = \"env\";
  buildInputs = [
  ];
  shellHooks = '''
  ''';
}"
          $EDITOR shell.nix
        end
      end
    '';
  };
}
