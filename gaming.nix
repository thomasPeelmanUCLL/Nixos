# gaming.nix
{ pkgs, inputs,  system,  ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
    "fs.file-max" = 524288;
  };

  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
    ];
  };

  environment.systemPackages = with pkgs; [
   inputs.nix-citizen.packages.${system}.rsi-launcher
    wget
    rnnoise-plugin
    git
    mesa-demos
    libva-utils
    pciutils
    lm_sensors
    vim
    baobab
    nil
    nixfmt-rfc-style
    fastfetch
  ];
}
