{config, ...}: let
  flakeUsers = config.rynix.users;
in {
  perRynixConfiguration = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mapAttrs mkOption types;
    mkPerUserType = module:
      types.deferredModuleWith {
        staticModules = [module];
      };
    allPerUserConfigs = mapAttrs (username: flakeUser: (config.users.perUser flakeUser)) flakeUsers;
  in {
    options.users = {
      perUser = mkOption {
        type = mkPerUserType {
          options = {
            user = mkOption {
              type = with types; attrsOf anything;
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
              inherit user;
              inherit (user) details groups uid username;
            };
            class = "perUser";
          }).config;
      };
      allPerUserConfigs = mkOption {
        type = with types; attrsOf anything;
        description = "The perUser outputs for each user.";
        internal = true;
      };
    };
    config = {
      _module.args = {inherit mkPerUserType;};
      users = {
        inherit allPerUserConfigs;
        perUser = {user = {};};
        users = mapAttrs (_: builtins.getAttr "user") allPerUserConfigs;
      };
    };
  };
}
