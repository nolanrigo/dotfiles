{ config, ... }:

# BOOT:
# Describe interactions between nixos and /boot
#
# Note: /boot device is describe in ./hardware-configuration.nix

{
  # Look: https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#Grub_2
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    # Disable: systemd-boot.enable = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      version = 2;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root F84D-0453
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  # Make time compatible with Windows
  time.hardwareClockInLocalTime = true;
}
