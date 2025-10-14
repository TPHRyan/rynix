{
  config,
  lib,
  mkSystemOptions,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.rynix.systems = mkSystemOptions {
    system = mkOption {
      type = types.str;
    };
  };
  config.systems =
    lib.attrsets.foldlAttrs (
      systems: name: {system, ...}:
        if builtins.elem system systems
        then systems
        else systems ++ [system]
    ) []
    config.rynix.systems;
}
