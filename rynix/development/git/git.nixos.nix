{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.programs.git;
in {
  config = {
    programs.git.enable = mkDefault true;
    users.perUser.home = {
      imports = [
        ./git.home.nix
      ];
      config.programs.git.enable = mkDefault cfg.enable;
    };
  };
}
