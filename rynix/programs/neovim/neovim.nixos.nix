{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.programs.neovim;
in {
  config = {
    programs.neovim.enable = mkDefault true;
    users.perUser.home = {
      imports = [
        ./neovim.home.nix
      ];
      config.programs.neovim.enable = mkDefault cfg.enable;
    };
  };
}
