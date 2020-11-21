let
  inherit (builtins) concatLists map listToAttrs;
  workspaceToKeybind = alt: workspace: [
    { name = "${alt}+${workspace}"; value = "workspace ${workspace}"; }
    { name = "${alt}+Shift+${workspace}"; value = "move container to workspace ${workspace}"; }
  ];
in alt: workspaces: listToAttrs (concatLists (map (workspaceToKeybind alt) workspaces))
