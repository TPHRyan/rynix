{
  mkUserOptions,
  config,
  lib,
  ...
}: let
  inherit (lib) mapAttrs mkDefault mkOption types;
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
  config.perRynixConfiguration = {
    users.users =
      mapAttrs (
        username: flakeUser: {
          enable = mkDefault false;
          isNormalUser = mkDefault true;
          createHome = mkDefault true;
          inherit (flakeUser) uid;
          extraGroups = flakeUser.groups;
          openssh.authorizedKeys.keys = flakeUser.authorizedKeys;
        }
      )
      flakeUsers;
  };
}
