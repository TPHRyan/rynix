{
  lib,
  useKeyAsDefaultFor,
  ...
}: let
  inherit (lib) mkOption types;
  mkSystemOptions = extraCfg: systemOpts:
    mkOption (
      {
        type = with types;
          attrsOf (submodule {
            options = systemOpts;
          });
      }
      // extraCfg
    );
in {
  imports = [
    ./flakeSystems.nix
    ./nixosConfigurations.nix
  ];
  options.rynix = {
    globalModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [];
    };
    systems =
      mkSystemOptions {
        default = {};
        apply = lib.attrsets.mapAttrs (useKeyAsDefaultFor "name");
      } {
        name = mkOption {
          type = types.str;
          description = ''
            A name for the system. If undefined, the system's
            key in the attrset will be used.
          '';
        };
      };
  };
  config._module.args = {
    mkSystemOptions = mkSystemOptions {};
  };
}
