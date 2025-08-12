{
  imports = [
    ./hardware-configuration.nix
  ];
  config = {
    boot.initrd.availableKernelModules = ["usb_storage"];

    # Additional mountpoints
    fileSystems."/data" = {
      device = "/dev/disk/by-uuid/3B2948425D824ABA";
      fsType = "ntfs";
    };
  };
}
