{ config, pkgs, ... }:

# BOOT:
# Describe interactions between nixos and /boot
#
# Note: /boot device is describe in ./hardware-configuration.nix

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
