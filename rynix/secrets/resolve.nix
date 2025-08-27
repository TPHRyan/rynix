{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  secretsRootPath = config.rynix.secrets.path;
in {
  options.rynix.secrets = {
    path = mkOption {
      type = types.path;
      description = "The path to the agenix secrets folder.";
    };
  };
  config = {
    _module.args = {
      resolveSecrets = secretsConfig: secretsConfig secretsRootPath;
    };
  };
}
