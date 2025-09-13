{
  perRynixConfiguration = {
    mkPerUserType,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption types;
    allPerUserConfigs = config.users.allPerUserConfigs;
    perUserSharedHomeModules =
      builtins.map
      (builtins.getAttr "home")
      (builtins.attrValues allPerUserConfigs);
  in {
    options.users.perUser = mkOption {
      type = mkPerUserType {
        options = {
          home = mkOption {
            type = types.deferredModule;
            description = ''
              A Home Manager module added here is applied to every user.
            '';
          };
        };
      };
    };
    config = {
      home-manager.sharedModules = perUserSharedHomeModules;
      users.perUser = {home = {};};
    };
  };
}
