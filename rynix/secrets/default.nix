{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  mkSecretsOption = import ./lib/mkSecretsOption.nix;
  cfg = config.rynix.secrets;
  agenix = cfg.agenix.input;
in {
  imports = [
    ./global.nix
    ./environment.nix
    ./resolve.nix
    ./system.nix
  ];
  options.rynix.secrets = {
    agenix.input = mkOption {
      type = types.raw;
      default = inputs.agenix;
    };
  };
  config = {
    _module.args = {
      inherit mkSecretsOption;
    };
    perRynixConfiguration = {
      imports = [agenix.nixosModules.default];
    };
  };
}
