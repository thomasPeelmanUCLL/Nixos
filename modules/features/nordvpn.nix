{ ... }:

{
  flake.nixosModules.nordvpn = {pkgs, ...}: {
  services.nordvpn = {
    enable = true;
    user = "bob" ;
  };

  networking.firewall.checkReversePath = "loose";
  };
}

