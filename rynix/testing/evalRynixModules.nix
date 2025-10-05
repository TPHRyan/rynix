{evalModules, ...}: let
  # TODO: Definitely want some more robust test harness but need to figure out what it looks like
  #         (the modules imported definitely need to be somewhat dynamic)
  modulesPath = ./..;
  defaultModules = [
    "${modulesPath}/systems"
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
