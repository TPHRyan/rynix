{
  config,
  lib,
  mkBootstrapModule,
  mkSystemOptions,
  nixosSystem,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.rynix;
in {
  options.rynix.systems = mkSystemOptions {
    configuration = mkOption {
      type = types.deferredModule;
    };
  };
  config.flake.nixosConfigurations =
    lib.attrsets.mapAttrs (
      name: systemConfig @ {configuration, ...}:
        nixosSystem {
          specialArgs = {};
          modules =
            [
              (mkBootstrapModule systemConfig)
              configuration
            ]
            ++ cfg.globalModules;
        }
    )
    cfg.systems;
}
