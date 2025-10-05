{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  flakeCfg = config.nixpkgs;
  nixpkgs = flakeCfg.input;
  mkNixpkgsConfig = localConfig: flakeCfg.config // localConfig;
in {
  options.nixpkgs = {
    config = mkOption {
      type = with types; lazyAttrsOf anything;
      internal = true;
    };
  };
  config = {
    nixpkgs.config = {
      config = {};
    };
    perSystem = {system, ...}: {
      _module.args = {
        pkgs = import nixpkgs (mkNixpkgsConfig {
          localSystem.system = system;
        });
      };
    };
    perRynixConfiguration = {config, ...}: {
      nixpkgs = mkNixpkgsConfig {
        hostPlatform.system = config.system.rynix.system;
      };
    };
  };
}
