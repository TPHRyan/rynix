{
  description = "Ryan's NixOS and home-manager setup";

  inputs = {
    flake-parts.url = "flake:flake-parts";
    nixpkgs.url = "flake:nixpkgs/nixos-unstable";
    rynixpkgs = {
      url = "git+ssh://git@gitlab.com/TPHRyan/ry-po.git?ref=main&dir=rynixpkgs";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {
        inherit (nixpkgs.lib) nixosSystem;
      };
    } {
      imports = [
        ./rynix
        ./dev.nix
        ./systems
      ];
    };
}
