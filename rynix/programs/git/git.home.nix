{
  currentUser,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkMerge;
in {
  config = mkMerge [
    (
      mkIf config.programs.git.enable {
        programs.git.settings = {
          pull.rebase = true;
          user = {inherit (currentUser.details) name email;};
        };
      }
    )
    (
      # We can't check oh-my-zsh.enable due to infinite recursion
      mkIf config.programs.zsh.enable {
        programs.zsh.oh-my-zsh.plugins = [
          "git"
          "git-lfs"
        ];
      }
    )
  ];
}
