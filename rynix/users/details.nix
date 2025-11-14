{
  mkUserOptions,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.rynix.users = mkUserOptions {
    details = {
      name = mkOption {
        type = types.str;
        default = "Anonymous";
      };
      email = mkOption {
        type = types.str;
        default = "user@example.com";
      };
    };
  };
}
