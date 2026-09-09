{ ... }:

{
  flake.nixosModules.docker = {pkgs,config, ...}: {
  virtualisation.docker = {
    enable = true;

    enableOnBoot = true;

    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;  
    # };

    # daemon.settings = {
    #   "data-root" = "/data/docker";
    # };
  };


  systemd.services.docker = {
    enable = true;         
    wantedBy = [];         

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
  systemd.sockets.docker = {
        enable = true;
        wantedBy = [];
      };
  };
}
