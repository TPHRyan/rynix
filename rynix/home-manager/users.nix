{
  mkUserOptions,
  config,
  lib,
  ...
}: let
  inherit (lib) mapAttrs mkOption types;
  flakeUsers = config.rynix.users;
in {
  options.rynix = {
    users = mkUserOptions {
      home = mkOption {
        type = types.raw;
        description = ''
          The Home Manager config for this user.
          Leave empty if Home Manager should not be used for this user.
        '';
        default = {};
      };
    };
  };
  config = {
    perRynixConfiguration = {
      home-manager.users = mapAttrs (_: builtins.getAttr "home") flakeUsers;
    };
  };
}
