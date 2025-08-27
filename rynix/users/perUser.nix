{config, ...}: let
  flakeUsers = config.rynix.users;
in {
  perRynixConfiguration = {
    config,
    lib,
    ...
  }: let
    inherit (lib) genAttrs mapAttrs mkDefault mkOption types;
    mkPerUserType = module:
      types.deferredModuleWith {
        staticModules = [module];
      };
    enabledUsernames = config.system.rynix.users;
    allPerUserConfigs = genAttrs enabledUsernames (username: config.perUser flakeUsers.${username});
  in {
    options = {
      perUser = mkOption {
        type = mkPerUserType {
          options = {
            user = mkOption {
              type = types.anything;
              default = {};
            };
          };
        };
        description = ''
          A function which defines configuration for every user defined.

          Note that this only applies to globally-defined users (defined in 'config.rynix.users').
        '';
        apply = module: user:
          (lib.evalModules {
            modules = [module];
            prefix = ["perUser" user.key];
            specialArgs = {
              inherit (user) name;
            };
            class = "perUser";
          }).config;
      };
      allPerUserConfigs = mkOption {
        type = with types; lazyAttrsOf raw;
        description = "The perUser outputs for each user.";
        internal = true;
      };
    };
    config = {
      inherit allPerUserConfigs;
      _module.args = {inherit mkPerUserType;};
      users.users = mapAttrs (name: {user, ...}: user) allPerUserConfigs;
      perUser = mkDefault {};
    };
  };
}
