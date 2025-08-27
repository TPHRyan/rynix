{nixpkgs, ...}: let
  inherit (nixpkgs.lib) mkOption nixosSystem types;
in
  {
    name,
    system,
    configuration,
    users ? ["ryan"],
    ...
  }: {
    imports = [
      ({config, ...}: {
        options.rynix = {
          configurations = mkOption {
            type = with types; lazyAttrsOf deferredModule;
          };
          globalModules = mkOption {
            type = with types; listOf deferredModule;
            default = [];
          };
        };
        config = let
          bootstrapModule = import ./bootstrap.module.nix {inherit name system users;};
          rynix = config.rynix;
          assertUserDefinedCentrally = username: {
            assertion = builtins.hasAttr username rynix.users;
            message = ''
              Definition not found for user '${username}' (system: '${name}')!
              All users added via 'rynixSystem' should be defined in the flake's 'config.rynix.users'.
            '';
          };
        in {
          rynix.configurations.${name} = configuration;
          flake.nixosConfigurations.${name} = nixosSystem {
            specialArgs = {};
            modules =
              [
                {
                  assertions = builtins.map assertUserDefinedCentrally users;
                }
                bootstrapModule
                rynix.configurations.${name}
              ]
              ++ config.rynix.globalModules;
          };
        };
      })
    ];
  }
