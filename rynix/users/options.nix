{lib, ...}: let
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
      apply = lib.attrsets.mapAttrs (
        key: user: let
          nameResult = builtins.tryEval user.name;
          name =
            if nameResult.success
            then nameResult.value
            else key;
        in
          user // {inherit key name;}
      );
    } {
      key = mkOption {
        type = types.str;
        internal = true;
      };
      name = mkOption {
        type = with types; passwdEntry str;
        description = ''
          The name of the user account. If undefined, the
          user's key will be used.
        '';
      };
    };
  config._module.args = {
    mkUserOptions = mkUserOptions {};
  };
}
