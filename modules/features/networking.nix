{ ... }:

{
  flake.nixosModules.networking = {
    networking = {
      hostName = "nixos";
      networkmanager = {
        enable = true;

        ensureProfiles.profiles."Wired static" = {
            connection = {
            id = "Wired static";
            type = "ethernet";
            interface-name = "enp42s0";
            autoconnect = true;
            };

            ipv4 = {
            method = "manual";
            addresses = "192.168.88.223/24";
            gateway = "192.168.88.1";
            dns = "192.168.88.1;1.1.1.1;";
            };

            ipv6 = {
            method = "auto";
            };
        };
      };

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