{
  currentUser,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config.programs.git = mkIf config.programs.git.enable {
    settings = {
      pull.rebase = true;
      user = {inherit (currentUser.details) name email;};
    };
  };
}
