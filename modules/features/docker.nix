{ ... }:

{
  flake.nixosModules.docker = {pkgs, ...}: {
    # Docker daemon inschakelen
  virtualisation.docker = {
    enable = true;

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

  # Gebruikers toegang geven tot docker
  # Pas <jouw-user> aan naar je username (bijv. "bob")
  users.users.bob.extraGroups = [ "docker" ];

  # Zorg dat Docker pas start na netwerk
  systemd.services.docker = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
  };
}
