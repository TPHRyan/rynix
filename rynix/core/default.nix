{
  imports = [
    ./nix.nix
  ];
  config.perRynixConfiguration = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkDefault;
  in {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    services.openssh = {
      settings.PasswordAuthentication = mkDefault false;
    };
  };
}
