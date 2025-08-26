{
  config,
  lib,
  ...
}: {
  systems =
    lib.attrsets.foldlAttrs (
      systems: name: {config, ...}: let
        system = config.nixpkgs.hostPlatform.system;
      in
        if builtins.elem system systems
        then systems
        else systems ++ [system]
    ) []
    config.flake.nixosConfigurations;
}
