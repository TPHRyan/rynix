{config, ...}: {
  imports = [];
  config = {
    virtualisation.vmVariant = {
      config.virtualisation = {
        cores = 4;
        memorySize = 8192;
        diskImage = "/home/ryan/.cache/rynix/${config.system.name}.qcow2";
        forwardPorts = [
          {
            from = "host";
            host.port = 2222;
            guest.port = 22;
          }
        ];
      };
    };

    # Mostly stubs to avoid failing checks
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    boot.loader.grub.enable = false;

    users.users.ryan.enable = true;

    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Don't do it
  };
}
