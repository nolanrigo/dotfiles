{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  # Nixos
  system = {
    stateVersion = params.nixos.version;
    autoUpgrade = {
      enable = false;
      allowReboot = false;
      channel = "https://nixos.org/channels/nixos-${params.nixos.version}";
    };
  };

  # Swapiness to 0
  # Note: I want to use my 16go swap only if there is not other options
  boot.kernel.sysctl."vm.swap" = 0;

  # Use all firmware (unfree too)
  hardware.enableAllFirmware = true;

  # Don't upate microcode as I am on my comany computer
  hardware.cpu.intel.updateMicrocode = false;
}
