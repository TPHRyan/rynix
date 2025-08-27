{rynixSystem, ...}:
rynixSystem {
  name = "rynix-dev";
  system = "x86_64-linux";
  users = ["ryan"];
  configuration = import ./configuration.nix;
}
