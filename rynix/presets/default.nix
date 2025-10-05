{
  perRynixConfiguration = {
    config,
    lib,
    ...
  }: let
    systemName = config.system.rynix.configName;
    presets = config.system.rynix.presets;
    presetExists = preset: let
      presetPath = ./. + "/${preset}.nix";
    in
      builtins.pathExists presetPath;

    enabledPresets = lib.attrsets.genAttrs presets (preset: true);
    isPresetEnabled = preset: enabledPresets.${preset} or false;
  in {
    imports = [
      ./desktop.nix
    ];
    config = {
      _module.args = {
        inherit isPresetEnabled;
      };
      assertions =
        builtins.map (preset: {
          assertion = presetExists preset;
          message = ''
            Preset '${preset}' defined for system '${systemName}' does not exist!
            Please ensure all preset names provided to 'rynixSystem' correspond to valid presets.
          '';
        })
        presets;
    };
  };
}
