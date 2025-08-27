lib: let
  inherit (lib) mkOption types;
in
  mkOption {
    type = types.attrsOf types.str;
    default = {};
    apply = secrets: rootPath:
      lib.attrsets.mapAttrs (name: path: {
        file = lib.path.append rootPath path;
      })
      secrets;
  }
