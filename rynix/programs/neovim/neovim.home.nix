{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf;
in {
  imports = [
    ./plugins.home.nix
  ];
  config.programs.neovim = mkIf config.programs.neovim.enable {
    defaultEditor = mkDefault true;
    vimAlias = mkDefault true;
    vimdiffAlias = mkDefault true;
    extraConfig = ''
      set number
      set relativenumber
    '';
  };
}
