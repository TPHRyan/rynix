{
  name,
  system,
  users,
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
      users = mkOption {
        type = with types; listOf str;
        readOnly = true;
      };
    };
  };
  config = {
    system.rynix = {
      inherit system users;
      configName = name;
    };
    networking.hostName = mkDefault cfg.configName;
    users.users = lib.attrsets.genAttrs users (username: {enable = true;});
  };
})
