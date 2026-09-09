{ ... }:

{
  flake.nixosModules.database = {pkgs, ...}: {
    services.postgresql = {
    enable = true;

    # Optional: pin a specific PostgreSQL major version
    # package = pkgs.postgresql_16;

    ensureDatabases = [
      "myapp"
      "inventory_app"
    ];

    ensureUsers = [
      {
        name = "myapp";
        ensureDBOwnership = true;
      }
    ];
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb_110;  # or pkgs.mariadb for default
  };

  environment.systemPackages = [
    pkgs.postgresql
    pkgs.mariadb
  ];
  };
}
