inputs: {
  rynixSystem = import ./lib/rynixSystem.nix {
    inherit inputs;
    rynixRoot = ./.;
    entryModule = ./rynix.nix;
  };
}
