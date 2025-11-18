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
      mkIf config.programs.zsh.oh-my-zsh.enable {
        programs.zsh.oh-my-zsh.plugins = [
          "git"
          "git-lfs"
        ];
      }
    )
  ];
}
