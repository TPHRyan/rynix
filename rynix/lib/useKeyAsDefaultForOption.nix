name: key: config: let
  optionResult = builtins.tryEval config.${name};
  resolvedValue =
    if optionResult.success
    then optionResult.value
    else key;
in
  config
  // {
    ${name} = resolvedValue;
  }
