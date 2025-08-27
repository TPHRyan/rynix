{
  mkSecretsOption,
  resolveSecrets,
  config,
  lib,
  ...
}: let
  cfg = config.rynix.secrets;
  flakeSecrets = resolveSecrets cfg.secrets;
in {
  options.rynix.secrets = {
    secrets = mkSecretsOption lib;
  };
  config.perRynixConfiguration = {
    age.secrets = flakeSecrets;
  };
}
