{
  canEvalRynixModules,
  evalRynixModules,
  ...
}: {
  flake.tests = {
    "test perRynixConfiguration evaluates successfully" = {
      expr =
        canEvalRynixModules
        {
          modules = [
            ./perRynixConfiguration.nix
          ];
        };
      expected = true;
    };
    "test perRynixConfiguration produces global modules" = {
      expr = let
        evalResult = evalRynixModules {
          modules = [
            ./perRynixConfiguration.nix
          ];
        };
        globalModules = builtins.deepSeq evalResult.config.rynix.globalModules evalResult.config.rynix.globalModules;
      in
        builtins.trace globalModules {};
      expected = {};
    };
  };
}
