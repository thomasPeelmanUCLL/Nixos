{ ... }:

{
  flake.nixosModules.database = {pkgs, ...}: {
    services.postgresql = {
    enable = true;

    # Optional: pin a specific PostgreSQL major version
    # package = pkgs.postgresql_16;

    ensureDatabases = [
      "myapp"
    ];

    ensureUsers = [
      {
        name = "myapp";
        ensureDBOwnership = true;
      }
    ];
  };

  environment.systemPackages = [
    pkgs.postgresql
  ];
  };
}
