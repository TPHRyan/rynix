{lib, ...}: {
  _module.args = {
    mkBootstrapModule = import ./mkBootstrapModule.nix;
    useKeyAsDefaultFor = import ./useKeyAsDefaultFor.nix {inherit lib;};
  };
}
