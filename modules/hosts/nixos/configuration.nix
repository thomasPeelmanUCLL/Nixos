# Core system configuration for the "nixos" host.
{ self, ... }:

{
  flake.nixosModules.nixos-configuration = {
    imports = [
      self.nixosModules.nixos-hardware
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.nvidia
      self.nixosModules.packages
      self.nixosModules.obsstudio
      self.nixosModules.user-bob
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelModules = [ "nvidia" ];
    boot.kernelParams = [ "pcie_aspm=off" ];

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Brussels";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "weekly";

    nix.gc.automatic = true;
    nix.gc.dates = "daily";
    nix.gc.options = "--delete-older-than 10d";
    nix.settings.auto-optimise-store = true;

    system.stateVersion = "25.11";
  };
}
