{nixpkgs, ...}: let
  inherit (nixpkgs.lib) mkOption nixosSystem types;
in
  {
    name,
    system,
    configuration,
    ...
  }: {
    imports = [
      ({config, ...}: {
        options.rynix = {
          configurations = mkOption {
            type = types.lazyAttrsOf types.deferredModule;
          };
          globalModules = mkOption {
            type = types.listOf types.deferredModule;
            default = [];
          };
        };
        config = let
          bootstrapModule = import ./bootstrap.module.nix {inherit name system;};
          rynix = config.rynix;
        in {
          rynix.configurations.${name} = configuration;
          flake.nixosConfigurations.${name} = nixosSystem {
            specialArgs = {};
            modules =
              [
                bootstrapModule
                rynix.configurations.${name}
              ]
              ++ config.rynix.globalModules;
          };
        };
      })
    ];
  }
