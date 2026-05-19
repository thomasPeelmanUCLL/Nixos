# Gaming: Steam, GameMode, Star Citizen (via nix-citizen NixOS module), Lutris, Heroic, Bottles.
{ inputs, ... }:

{
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = [
      inputs.nix-citizen.nixosModules.default
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };

    # Star Citizen via nix-citizen module
    programs.rsi-launcher = {
      enable = true;
      preCommands = ''
        export MANGOHUD=1;
      '';
    };

    nix.settings = {
      substituters = [ "https://nix-citizen.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      ];
    };

    environment.systemPackages = with pkgs; [
      rnnoise-plugin
      mangohud
      protonup-ng
      lutris
      heroic
      bottles
    ];

    programs.gamemode.enable = true;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
