{inputs, ...}: {
  imports = [inputs.nix-unit.modules.flake.default];
  perSystem = {
    nix-unit.inputs = {
      inherit
        (inputs)
        agenix
        flake-parts
        nix-unit
        nixpkgs
        nur
        rynixpkgs
        ;
    };
  };
}
