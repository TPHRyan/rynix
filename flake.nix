{
  description = "Ryan's NixOS and home-manager setup";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        darwin.follows = "";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
    nur,
    rynixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {
        rynixSystem = import ./lib/rynixSystem.nix inputs;
      };
    } {
      imports = [
        ./dev.nix
        ./nix-unit.nix
        ./rynix
        ./systems
        ./users
      ];
      debug = true;
      nixpkgs = {
        overlays = [
          nur.overlays.default
          rynixpkgs.overlays.default
        ];
      };
      rynix.secrets.path = ./secrets;
    };
}
