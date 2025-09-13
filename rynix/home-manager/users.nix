{
  mkUserOptions,
  config,
  lib,
  ...
}: let
  inherit (lib) foldlAttrs mkOption types;
  flakeUsers = config.rynix.users;
  getHomeConfigs = foldlAttrs (
    homeConfigs: name: {home, ...}:
      if home == {}
      then homeConfigs
      else homeConfigs // {${name} = home;}
  ) {};
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
    _module.args = {
      inherit getHomeConfigs;
    };
    perRynixConfiguration = {
      home-manager.users = getHomeConfigs flakeUsers;
    };
  };
}
