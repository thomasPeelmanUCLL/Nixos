{ ... }:

{
  flake.nixosModules.networking = {
    networking = {
      hostName = "nixos";
      networkmanager.enable = true;

      firewall = {
        enable = true;
        allowedUDPPorts = [
          41641 # Tailscale
        ];
      };
    };

    services.tailscale.enable = true;
  };
}