inputs: {
  rynixSystem = import ./lib/rynixSystem.nix {
    inherit inputs;
    entryModule = ./rynix.nix;
  };
}
