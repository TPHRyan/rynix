{lib, ...}: let
  inherit (lib) evalModules;
in {
  flake.tests = {
    "test perRynixConfiguration evaluates successfully" = let
      result = evalModules {
        modules = [
          ./perRynixConfiguration.nix
          {}
        ];
      };
    in {
      expr = result;
      expected = "yes";
    };
  };
}
