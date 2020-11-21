{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    # Git
    programs.git = {
      enable = true;
      userName = "Nolan Rigo";
      userEmail = "nolan@rigo.dev";

      extraConfig = {
        github.user = "nolanrigo";

        init = {
          defaultBranch = "main";
        };

        alias = {
          lg = "log --graph --date=relative --pretty=tformat:'%Cred%h%Creset - %C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset'";
        };

        core = {
          pager = "cat";
          autocrlf = "input";
          ignorecase = "false";
          whitespace = "trailing-space,space-before-tab";
        };

        apply = {
          whitespace = "fix";
        };

        status = {
          showUntrackedFiles = "all";
          submoduleSummary = "true";
        };

        diff = {
          wordRegex = ".";
          mnemonicPrefix = "true";
          renames = "true";
          submodule = "log";
        };

        color = {
          ui = "auto";
        };

        "color \"branch\"" = {
          upstream = "cyan";
        };

        log = {
          abbrevCommit = "true";
          follow = "true";
        };

        grep = {
          extendedRegexp = "true";
        };

        fetch = {
          recurseSubmodules = "on-demand";
        };

        push = {
          default = "upstream";
          followTags = "true";
        };

        pull = {
          rebase = "merges";
        };

        rebase = {
          autosquash = "true";
        };

        tag = {
          sort = "version:refname";
        };

        merge = {
          log = "true";
          conflictStyle = "diff3";
        };

        rerere = {
          enabled = "true";
          autoupdate = "true";
        };
      };

      ignores = [
        ".ssh/id_rsa"
        ".ssh/id_rsa.pub"
      ];
    };

    # Git as fish abbrs
    programs.fish.shellAbbrs = {
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
    };
  };
}

