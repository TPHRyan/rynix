{
  lib,
  useKeyAsDefaultFor,
  ...
}: let
  inherit (lib) mkOption types;
  mkUserOptions = extraCfg: userOpts:
    mkOption (
      {
        type = with types;
          attrsOf (submodule {
            options = userOpts;
          });
      }
      // extraCfg
    );
in {
  options.rynix.users =
    mkUserOptions {
      default = {};
      apply = lib.attrsets.mapAttrs (useKeyAsDefaultFor ["key" "username"]);
    } {
      key = mkOption {
        type = types.str;
        internal = true;
      };
      username = mkOption {
        type = with types; passwdEntry str;
        description = ''
          The name of the user account. If undefined, the
          user's key in the attrset will be used.
        '';
      };
    };
  config._module.args = {
    mkUserOptions = mkUserOptions {};
  };
}
