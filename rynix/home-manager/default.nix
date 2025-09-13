{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  home-manager = config.rynix.home-manager.input;
in {
  imports = [
    ./perUser.nix
    ./users.nix
  ];
  options.rynix = {
    home-manager.input = mkOption {
      type = types.raw;
      default = inputs.home-manager;
    };
  };
  config.perRynixConfiguration = {
    imports = [home-manager.nixosModules.default];
    config = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
  };
}
