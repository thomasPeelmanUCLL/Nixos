# System-wide packages.
{ ... }:

{
  flake.nixosModules.packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      vim
    ];
  };
}
