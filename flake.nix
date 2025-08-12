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

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {
        rynixSystem = import ./lib/rynixSystem.nix inputs;
      };
    } {
      imports = [
        ./rynix
        ./systems
      ];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };
    };
}
