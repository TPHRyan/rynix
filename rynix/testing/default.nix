{
  lib,
  rynixRoot,
  ...
}: let
  evalRynixModules = import ./evalRynixModules.nix {
    inherit (lib) evalModules;
    inherit rynixRoot;
  };
in {
  _module.args = {
    inherit evalRynixModules;
    canEvalRynixModules =
      import ./canEvalRynixModules.nix {inherit evalRynixModules;};
  };
}
