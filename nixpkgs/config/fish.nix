{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      # Project
      cpf = "cd ~/Projects/filtercast;";
      cpd = "cd ~/dotfiles";
      cpe = "cd ~/Projects/project-e;";
      cpec = "cd ~/Projects/project-e/crawlers;";
      cpei = "cd ~/Projects/project-e/infra;";
      cpeai = "cd ~/Projects/project-e/api;";
      cpead = "cd ~/Projects/project-e/admin;";
      cpeau = "cd ~/Projects/project-e/auth;";
      cpeb = "cd ~/Projects/project-e/builder;";
      cpebw = "cd ~/Projects/project-e/builder/website;";
      cpebi = "cd ~/Projects/project-e/builder/infra;";
      cpebe = "cd ~/Projects/project-e/builder/edge;";

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
      nid = "npm i -D";
      nci = "npm ci";
      nun = "npm un";
      nh = "npm home";
      nr = "npm repo";
      ns = "npm start";
      nt = "npm test";
      ntu = "npm test -- -u";
      nb = "npm run build";
      nd = "npm run dev";
      nl = "npm run lint";
      ncl = "npm run clear";
      ncu = "npx npm-check-updates -u";

      # Yarn
      y = "yarn";
      ya = "yarn add";
      yad = "yarn add --dev";
      ys = "yarn start";
      yb = "yarn build";
      yd = "yarn dev";

      # Rails
      r = "rails";
      rs = "rails server";
      rc = "rails console";

      # Terraform
      t = "terraform";
      ti = "terraform init";
      ta = "terraform apply";
      taa = "terraform apply -auto-approve";
      tp = "terraform plan";
      td = "terraform destroy";

      # System
      e = "nvim";
      hms = "home-manager switch";
      hmsi3 = "home-manager switch; i3-msg restart";
      nrs = "sudo nixos-rebuild switch";
      psgrep = "ps -ax | grep";
      rf = "rm -rf";

      # Copy / Paste
      copy = "xclip -selection clipboard";
      paste = "xclip -o -selection clipboard";
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
