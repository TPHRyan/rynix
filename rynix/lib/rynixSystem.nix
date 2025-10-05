{
  inputs,
  entryModule,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in
  {
    name,
    system,
    configuration,
    ...
  }: {
    imports = [
      entryModule
      ({config, ...}: {
        config = let
          bootstrapModule = import ./mkBootstrapModule.nix {inherit name system;};
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
