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
      self.nixosModules.database
      self.nixosModules.docker
      self.nixosModules.networking
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = [ "pcie_aspm=off"];

    time.timeZone = "Europe/Brussels";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    system.autoUpgrade = {
      enable = true;
      dates = "weekly";
      flake = "/etc/nixos";
      allowReboot = false;  # set true if you want it to reboot automatically after upgrade
      flags = [
        "--update-input" "nixpkgs"
        "--update-input" "nix-citizen"
        "--commit-lock-file"   # auto-commits flake.lock after update
      ];
    };


    nix.gc.automatic = true;
    nix.gc.dates = "daily";
    nix.gc.options = "--delete-older-than 10d";
    nix.settings.auto-optimise-store = true;

    system.stateVersion = "25.11";
  };
}
