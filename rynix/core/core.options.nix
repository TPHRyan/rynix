{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.rynix = {
    configurations = mkOption {
      type = types.lazyAttrsOf types.deferredModule;
    };
    globalModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [];
    };
  };
}
