{
  config,
  pkgs,
  ...
}: let
  fsUuid = fsName: builtins.baseNameOf config.fileSystems.${fsName}.device;
  uuids.esp = fsUuid "/boot";
  uuids.rescue = fsUuid "/";
in {
  boot.kernelParams = ["quiet"];
  boot.loader = {
    grub = {
      device = "nodev";
      efiSupport = true;
      # TODO: Set this better before finalizing
      extraEntries = ''
        menuentry 'Windows 11' {
          search --fs-uuid --set=root '${uuids.esp}'
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }

        menuentry 'Rescue (Arch Linux)' {
          echo 'Loading rescue Linux...'
          search --fs-uuid --set=root '${uuids.esp}'
          linux /EFI/ArchRescue/vmlinuz-linux root=UUID=${uuids.rescue} rw loglevel=3
          echo 'Loading initial ramdisk...'
          initrd /EFI/ArchRescue/initramfs-linux.img
        }
      '';
    };
    grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
      customResolution = "2560x1440";
    };
  };
  environment.systemPackages = with pkgs; [efibootmgr];
}
