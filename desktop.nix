# desktop.nix
{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
}
