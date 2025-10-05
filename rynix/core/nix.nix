{lib, ...}: let
  inherit (lib) mkDefault;
in {
  perRynixConfiguration = {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root"];
        download-buffer-size = "1073741824";
      };
      gc = {
        automatic = mkDefault true;
        dates = mkDefault "03:30";
        options = mkDefault "--delete-older-than 7d";
        persistent = mkDefault true;
      };
      optimise = {
        automatic = mkDefault true;
        dates = mkDefault ["03:45"];
      };
    };
  };
}
