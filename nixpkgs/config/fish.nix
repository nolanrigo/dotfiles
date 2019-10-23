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
      gca = "git commit --amend";
      gfu = "git commit --no-verify";
      gfa = "git commit --no-verify --amend";
      grb = "git rebase";
      grbi = "git rebase -i";
      grbc = "git rebase --continue";
      grba = "git rebase --abort";
      gpl = "git pull";
      gpu = "git push";
      gpuu = "git push -u origin";
      gm = "git merge";
      gss = "git stash save -u";
      gsp = "git stash pop --index";
      gsl = "git stash list";
      gsc = "git stash clear";

      # Npm
      n = "npm";
      nx = "npx";
      ni = "npm i";
      nid = "npm i -D";
      nci = "npm ci";
      nun = "npm un";
      nh = "npm home";
      nr = "npm repo";
      ns = "npm start";
      nt = "npm test";
      nb = "npm run build";
      nd = "npm run dev";
      ncl = "npm run clear";

      # Rails
      r = "rails";
      rs = "rails server";
      rc = "rails console";

      # Terraform
      t = "terraform";
      ta = "terraform apply";
      yta = "yes yes | terraform apply";
      tp = "terraform plan";
      td = "terraform destroy";

      # System
      psgrep = "ps -ax | grep";
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
