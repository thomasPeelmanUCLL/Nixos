{ ... }:

{
  flake.nixosModules.docker = {pkgs,config, ...}: {
  virtualisation.docker = {
    enable = true;

    enableOnBoot = false;

    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;  
    # };

    # daemon.settings = {
    #   "data-root" = "/data/docker";
    # };
  };


  systemd.services.docker = {
    enable = false;         
    wantedBy = [];         

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
  systemd.sockets.docker = {
        enable = false;
        wantedBy = [];
      };
  };
}
