{...}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];
  config = {
    networking.hostName = "ry-zen";

    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.05"; # Don't do it
  };
}
