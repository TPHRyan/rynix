{
  description = "Ryan's NixOS and home-manager setup";

  inputs = {
    flake-parts = {
      url = "flake:flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nix-unit = {
      url = "github:nix-community/nix-unit";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "flake:nixpkgs/nixos-unstable";
    nur = {
      url = "flake:nur";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
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
    nur,
    rynixpkgs,
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
        ./nix-unit.nix
        ./systems
      ];
      nixpkgs = {
        overlays = [
          nur.overlays.default
          rynixpkgs.overlays.default
        ];
      };
    };
}
