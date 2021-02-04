{ config, lib, pkgs, modulesPath, ... }:

let
  deps = import ./dependencies.nix;
in {
  imports = [
    (import "${deps.nixos-hardware}/lenovo/thinkpad/x1/7th-gen")
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
