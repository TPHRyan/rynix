{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf;
in {
  programs.zsh = mkIf config.programs.zsh.enable {
    autosuggestion.enable = mkDefault true;
    enableCompletion = mkDefault true;
    initContent = mkDefault ''
      bindkey '^ ' autosuggest-accept
      bindkey '^[ ' autosuggest-execute
    '';
  };
}
