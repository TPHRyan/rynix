{rynixSystem, ...}:
rynixSystem {
  name = "rynix-dev";
  system = "x86_64-linux";
  presets = ["desktop"];
  users = ["ryan"];
  configuration = import ./configuration.nix;
}
