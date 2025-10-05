{
  name,
  system,
  ...
}: ({
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkOption types;
  cfg = config.system.rynix;
in {
  options = {
    system.rynix = {
      configName = mkOption {
        type = types.str;
        readOnly = true;
      };
      system = mkOption {
        type = types.str;
        readOnly = true;
      };
    };
  };
  config = {
    system.rynix = {
      inherit system;
      configName = name;
    };
    networking.hostName = mkDefault cfg.configName;
    nixpkgs.hostPlatform = mkDefault cfg.system;
  };
})
