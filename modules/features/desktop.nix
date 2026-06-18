# Desktop environment: KDE Plasma 6 + SDDM + PipeWire.
{ ... }:

{
  flake.nixosModules.desktop = {
    services.displayManager.defaultSession = "plasma";
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.enable = true;


    environment.etc."xdg/kwinrc".text = ''
      [ModifierOnlyShortcuts]
      Meta=org.kde.plasmashell,/PlasmaShell,org.kde.PlasmaShell,activateLauncherMenu
    '';

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";

      # ADD THESE:
      __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";                  # Fixes VA-API decoding lag

      # New — fixes the Qt EGL crash (Spectacle loop + Discord SIGSEGV):
      QSG_RHI_BACKEND = "vulkan";
    };

    programs.kdeconnect.enable = true;
    programs.dconf.enable = true;

    services.xserver.xkb = {
      layout = "be";
      variant = "";
    };

    console.keyMap = "be-latin1";

    services.printing.enable = true;

    security.rtkit.enable = true;

    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    services.flatpak.enable = true;

  };
}

