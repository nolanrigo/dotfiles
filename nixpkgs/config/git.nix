{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Nolan Rigo";
    userEmail = "nolan@rigo.dev";

    #signing = {
    #  key = "";
    #  signByDefault = true;
    #};

    extraConfig = {
      github.user = "nolanrigo";

      alias = {
        lg = "log --graph --date=relative --pretty=tformat:'%Cred%h%Creset - %C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset'";
      };

      core = {
        editor = "nvim"; # we don't use "${pkgs.neovim}/bin/nvim"; because we need the patched nvim on path
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
        rebase = "preserve";
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

      # mergetool = {
        # keepBackup = false
        # keepTemporaries = false
        # writeToTemp = true
        # prompt = false
      # };

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
}
