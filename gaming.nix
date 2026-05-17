# gaming.nix
{ pkgs, nix-citizen, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    rnnoise-plugin
    git
    mesa-demos
    libva-utils
    pciutils
    lm_sensors
    vim
    wget
    baobab
    nil
    nixfmt-rfc-style
    fastfetch
    #nix-citizen.packages.x86_64-linux.rsi-launcher
  ];
}
