{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
in {
  options.nixpkgs = {
    allowedUnfreePackages = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };
  config.nixpkgs.config = {
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfreePackages;
  };
}
