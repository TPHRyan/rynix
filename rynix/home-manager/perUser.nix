{getHomeConfigs, ...}: {
  perRynixConfiguration = {
    mkPerUserType,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption types;
  in {
    options.perUser = mkOption {
      type = mkPerUserType {
        options = {
          home = mkOption {
            type = types.anything;
            description = ''
              Home Manager config here is applied to every user.
            '';
            default = {};
          };
        };
      };
    };
    config.home-manager.users = getHomeConfigs config.allPerUserConfigs;
  };
}
