# Gaming: Steam, GameMode, Star Citizen (nix-citizen), Lutris, Heroic, Bottles.
{ inputs, ... }:

{
  flake.nixosModules.gaming = { pkgs, lib, inputs, system, ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };

    boot.kernel.sysctl = {
      "vm.max_map_count" = 1048576;
      "fs.file-max" = 524288;
    };

    nix.settings = {
      substituters = [ "https://nix-citizen.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      ];
    };

    environment.systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.rsi-launcher
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
