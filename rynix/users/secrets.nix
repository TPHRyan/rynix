{
  mkUserOptions,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  flakeUsers = config.rynix.users;
  mkPasswdKey = username: "passwd-${username}";
  userSecrets =
    lib.attrsets.mapAttrs' (username: {hashedPasswordSecret, ...}: {
      name = mkPasswdKey username;
      value = hashedPasswordSecret.path;
    })
    flakeUsers;
in {
  options.rynix.users = mkUserOptions {
    hashedPasswordSecret.path = mkOption {
      type = types.str;
      description = ''
        Path to a secret that contains the hash of the user's password.
        (This path is relative to rynix.secrets.path)
      '';
    };
  };
  config = {
    rynix.secrets.secrets = userSecrets;
    perRynixConfiguration = {config, ...}: {
      users.users =
        lib.attrsets.mapAttrs (name: user: {
          hashedPasswordFile = config.age.secrets.${mkPasswdKey name}.path;
        })
        flakeUsers;
    };
  };
}
