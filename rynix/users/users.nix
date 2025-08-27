{
  mkUserOptions,
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkOption types;
  flakeUsers = config.rynix.users;
in {
  options.rynix.users = mkUserOptions {
    uid = mkOption {
      type = with types; nullOr ints.positive;
      default = null;
    };
    groups = mkOption {
      type = with types; listOf str;
      description = ''
        A list of groups this user should be a member of.
      '';
    };
    authorizedKeys = mkOption {
      type = with types; listOf singleLineStr;
      description = ''
        A list of OpenSSH public keys.
        (as defined for users.users.<name>.openssh.authorizedKeys.keys)
      '';
      default = [];
    };
  };
  config.perRynixConfiguration = {config, ...}: let
    enabledUsernames = config.system.rynix.users;
  in {
    users.users = lib.attrsets.genAttrs enabledUsernames (username: let
      user = flakeUsers.${username};
    in {
      enable = mkDefault true;
      isNormalUser = mkDefault true;
      createHome = mkDefault true;
      inherit (user) uid;
      extraGroups = user.groups;
      openssh.authorizedKeys.keys = user.authorizedKeys;
    });
  };
}
