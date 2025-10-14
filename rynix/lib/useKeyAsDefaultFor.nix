{lib, ...}: nameOrNames: key: config: let
  inherit (lib) genAttrs toList;
  names = toList nameOrNames;
  resolveValue = (
    name: let
      optionResult = builtins.tryEval config.${name};
    in
      if optionResult.success
      then optionResult.value
      else key
  );
in
  config
  // genAttrs names resolveValue
