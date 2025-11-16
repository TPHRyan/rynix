{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf;
in {
  # We can't check oh-my-zsh.enable due to infinite recursion
  programs.zsh.oh-my-zsh = mkIf config.programs.zsh.enable {
    enable = mkDefault true;
    theme = "agnoster";
    # TODO: plugins that can be moved immediately:
    #          "git"
    #          "git-lfs"
    plugins = [
      "sudo"
      "vi-mode"
    ];
  };
}
