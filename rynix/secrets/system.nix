{
  mkSecretsOption,
  resolveSecrets,
  ...
}: {
  perRynixConfiguration = {
    config,
    lib,
    ...
  }: let
    systemSecrets = resolveSecrets config.environment.secrets;
  in {
    options.environment.secrets = mkSecretsOption lib;
    config = {
      age.secrets = systemSecrets;
    };
  };
}
