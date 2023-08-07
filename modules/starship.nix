{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    programs.starship = {
      enable = true;
      enableTransience = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        line_break.truncate_to_repo = true;
        gcloud.disabled = true;
        time.disabled = false;

        # Colors
        aws.style = "bold #ffb86c";
        cmd_duration.style = "bold #f1fa8c";
        directory.style = "bold #50fa7b";
        hostname.style = "bold #ff5555";
        git_branch.style = "bold #ff79c6";
        git_status.style = "bold #ff5555";
        username = {
          format = "[$user]($style) on ";
          style_user = "bold #bd93f9";
        };
        character = {
          success_symbol = "[λ](bold #f8f8f2)";
          error_symbol = "[λ](bold #ff5555)";
        };

        custom.watson = let 
          watsonStatusCommand = pkgs.writeShellScriptBin "watson-status" ''
            project=$(bat ~/.config/watson/state | jq -r .project)
            tags=$(bat ~/.config/watson/state | jq -r '.tags | join(", ")')

            if [[ -n $project ]]; then
              echo -n " "
              echo -n $project
              if [[ -n $tags ]]; then
                echo -n " ($tags)"
              fi
              echo -n " "
              exit 0
            else
              echo ""
              exit 1
            fi
          '';
        in {
          command = "${watsonStatusCommand}/bin/watson-status";
          when = "true";
          description = "Affiche le statut de la tâche Watson en cours";
          format = "[$output ]($style)";
          style = "bold #8be9fd";
        };
      };
    };
  };
}
