{
  _module.args = {
    mkBootstrapModule = import ./mkBootstrapModule.nix;
    useKeyAsDefaultForOption = import ./useKeyAsDefaultForOption.nix;
  };
}
