# Entry point for the "nixos" host machine.
{ inputs, self, ... }:

{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    # inputs and system are passed here so NixOS modules can access them
    specialArgs = {
      inherit inputs;
      system = "x86_64-linux";
    };

    modules = [
      self.nixosModules.nixos-configuration
    ];
  };
}
