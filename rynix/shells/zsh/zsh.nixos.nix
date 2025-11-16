{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf mkMerge;
  cfg = config.programs.zsh;
in {
  config = mkMerge [
    {
      programs.zsh.enable = mkDefault true;
      users.perUser.home = {
        imports = [
          ./zsh.home.nix
        ];
        config.programs.zsh = {
          enable = mkDefault cfg.enable;
        };
      };
    }
    (mkIf cfg.enable {
      programs.zsh = {
        autosuggestions.enable = mkDefault true;
        enableCompletion = mkDefault true;
        syntaxHighlighting.enable = mkDefault true;
      };
      users.defaultUserShell = pkgs.zsh;
    })
  ];
}
