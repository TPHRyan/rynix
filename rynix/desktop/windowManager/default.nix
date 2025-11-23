{
  imports = [
    ./hyprland
  ];
  perRynixConfiguration = {
    imports = [
      ./wayland.nixos.nix
    ];
  };
}
