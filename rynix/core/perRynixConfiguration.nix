{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkOption types;
in {
  options = {
    perRynixConfiguration = mkOption {
      type = types.deferredModule;
      description = ''
        A function which defines configuration for every rynix system defined.

        This is helpful primarily for writing modules intended for more than one system.
      '';
    };
  };
  config = {
    rynix.globalModules = [config.perRynixConfiguration];
    perRynixConfiguration = mkDefault {};
  };
}
