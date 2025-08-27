{
  config,
  lib,
  mkSystemOptions,
  ...
}: let
  inherit (lib) mkOption types;
  flakeUsers = config.rynix.users;
in {
  options.rynix.systems = mkSystemOptions {
    users = mkOption {
      type = with types; listOf str;
      default = ["ryan"];
    };
  };
  config.perRynixConfiguration = {config, ...}: let
    cfg = config.system.rynix;
    assertUserDefinedCentrally = username: {
      assertion = builtins.hasAttr username flakeUsers;
      message = ''
        Definition not found for user '${username}' (system: '${cfg.configName}')!
        All users added via 'rynixSystem' should be defined in the flake's 'config.rynix.users'.
      '';
    };
  in {
    assertions = builtins.map assertUserDefinedCentrally cfg.users;
  };
}
