{ ... }:

{
  flake.nixosModules.docker = {pkgs,config, ...}: {
    # Docker daemon inschakelen
  virtualisation.docker = {
    enable = true;

    enableOnBoot = false;

    # Optioneel: rootless Docker (daemon als user, veiliger)
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;  # zet DOCKER_HOST voor je user
    # };

    # Optioneel: data op een andere locatie (bijv. grote disk)
    # daemon.settings = {
    #   "data-root" = "/data/docker";
    # };
  };


  # Zorg dat Docker pas start na netwerk
  systemd.services.docker = {
    enable = false;         # wel beschikbaar, maar...
    wantedBy = [];         # ...niet automatisch starten

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
  systemd.sockets.docker = {
        enable = false;
        wantedBy = [];
      };
  };
}
