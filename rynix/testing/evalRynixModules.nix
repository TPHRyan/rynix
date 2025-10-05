{
  evalModules,
  rynixRoot,
  ...
}: let
  defaultModules = [
    "${rynixRoot}/core/core.options.nix"
  ];
in
  {
    modules ? [],
    rynixConfigurations ? {test-system = {};},
    ...
  }:
    evalModules {
      modules =
        defaultModules
        ++ [
          {
            rynix.configurations = rynixConfigurations;
          }
        ]
        ++ modules;
    }
