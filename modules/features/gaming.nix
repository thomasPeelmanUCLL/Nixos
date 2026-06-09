# Gaming: Steam, GameMode, Star Citizen (nix-citizen), Lutris, Heroic, Bottles.
{ inputs, ... }:

{
  flake.nixosModules.gaming = { pkgs, system, inputs, ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };

    boot.kernel.sysctl = {
      "vm.max_map_count" = 1048576;
      "fs.file-max" = 524288;

      # ADD: needed for Wine/Proton esync
      "kernel.unprivileged_userns_clone" = 1;
    };

    nix.settings = {
      substituters = [ "https://nix-citizen.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      ];
    };

    security.pam.loginLimits = [
      { domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
      { domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
    ];

    environment.systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.rsi-launcher
      rnnoise-plugin
      mangohud
      protonup-ng
      lutris
      heroic
      bottles
      beyond-all-reason
      prismlauncher
      lunar-client
    ];

    programs.gamemode.enable = true;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";

      # Fix RSI Launcher CEF/ANGLE D3D renderer failure on Linux/NVIDIA
      # Forces the embedded Chromium to use OpenGL instead of D3D/ANGLE
      ANGLE_DEFAULT_PLATFORM = "gl";
      LIBGL_ALWAYS_SOFTWARE = "0";

      # Wayland/NVIDIA specific: ensure correct EGL platform
      EGL_PLATFORM = "wayland";

      PROTON_NO_ESYNC = "0";
      PROTON_NO_FSYNC = "0";
      PROTON_USE_WINED3D = "0";
      
      # Fix SIGSYS/seccomp issues with Wine on NixOS
      PRESSURE_VESSEL_FILESYSTEMS_RW = "$HOME";
    };
  };
}
