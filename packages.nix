{pkgs,  ...}:
{


environment.systemPackages = with pkgs; [
   # CLI essentials
    wget
    git
    vim

    # System inspection
    pciutils
    lm_sensors
    libva-utils
    mesa-demos
    fastfetch

    # Nix tooling
    nil
    nixfmt-rfc-style

    # Desktop utilities
    baobab
  ];
}
