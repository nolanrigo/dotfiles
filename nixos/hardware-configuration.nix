{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
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
      device = "/dev/disk/by-uuid/41a7e9fe-071e-4c08-a113-2b79fc151358";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/625E-2849";
      fsType = "vfat";
    };
  };
  swapDevices = [
    { device = "/dev/disk/by-uuid/8fa77a96-b239-47c9-b905-ff2f121239d3"; }
  ];
}
