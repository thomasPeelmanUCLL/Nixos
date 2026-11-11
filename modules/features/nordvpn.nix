{ config, lib, ... }:

{
  services.nordvpn = {
    enable = true;
    users = [ "grid777" ];
  };

  networking.firewall.checkReversePath = "loose";
}