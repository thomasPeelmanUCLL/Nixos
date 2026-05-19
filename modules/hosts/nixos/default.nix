# Entry point for the "nixos" host machine.
# Defines the NixOS system and wires in the configuration module.
{ inputs, self, ... }:

{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
      system = "x86_64-linux";
    };

    modules = [
      self.nixosModules.nixos-configuration
    ];
  };
}
