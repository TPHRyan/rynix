{
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./configure.nix
  ];
  options.nixpkgs = {
    input = mkOption {
      type = types.raw;
      default = inputs.nixpkgs;
    };
  };
}
