{rynixSystem, ...}:
rynixSystem {
  name = "rynix-dev";
  system = "x86_64-linux";
  configuration = import ./configuration.nix;
}
