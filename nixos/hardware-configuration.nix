{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Lenovo
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
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
      device = "/dev/disk/by-uuid/3663ae93-4a81-4ae7-8d1c-89856367e9de";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7494-732B";
      fsType = "vfat";
    };
  };
  swapDevices = [];
}
