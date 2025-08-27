{
  perRynixConfiguration = {
    config,
    lib,
    ...
  }: {
    services.openssh.enable = lib.mkDefault true;
    assertions = [
      {
        assertion = config.services.openssh.enable;
        message = "rynix secret management requires that openssh be enabled!";
      }
    ];
  };
}
