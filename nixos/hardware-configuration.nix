{ config, lib, pkgs, modulesPath, ... }:

let
  deps = import ./dependencies.nix;
in {
  imports = [
    # (import "${deps.nixos-hardware}/lenovo/thinkpad/x1/7th-gen")
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [];
    };
    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = [];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/fa0d46b3-2dfd-4971-900a-9ea982ea6bdc";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/13BD-1F47";
      fsType = "vfat";
    };
  };
  swapDevices = [];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
