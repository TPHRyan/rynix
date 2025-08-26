{
  perRynixConfiguration = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkDefault;
  in {
    config = {
      boot.kernelPackages = pkgs.linuxPackages_latest;
      services.openssh = {
        settings.PasswordAuthentication = mkDefault false;
      };
    };
  };
}
