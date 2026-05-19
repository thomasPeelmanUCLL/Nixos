# Hardware-specific configuration for the "nixos" host.
# Auto-generated — do not edit by hand unless you know what you're doing.
{ modulesPath, ... }:

{
  flake.nixosModules.nixos-hardware = {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    swapDevices = [];

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
