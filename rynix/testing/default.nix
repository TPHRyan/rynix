{lib, ...}: let
  evalRynixModules = import ./evalRynixModules.nix {
    inherit (lib) evalModules;
  };
in {
  _module.args = {
    inherit evalRynixModules;
    canEvalRynixModules =
      import ./canEvalRynixModules.nix {inherit evalRynixModules;};
  };
}
