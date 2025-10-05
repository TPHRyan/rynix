{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkOptionType types;
  overlayType = mkOptionType {
    name = "nixpkgs-overlay";
    description = "nixpkgs overlay";
    check = lib.isFunction;
    merge = lib.mergeOneOption;
  };
in {
  options.nixpkgs = {
    overlays = mkOption {
      type = types.listOf overlayType;
      default = [];
    };
  };
  config.nixpkgs.config = {
    inherit (config.nixpkgs) overlays;
  };
}
