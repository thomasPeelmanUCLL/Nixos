# System-wide packages.
{ ... }:

{
  flake.nixosModules.packages = { pkgs, ... }: {
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

      # rebuild using nh os switch /etc/nixos
      nh

      # Desktop utilities
      baobab
      dysk


      vlc
      mpv

      nvtopPackages.full

      remmina      # all-in-one GUI
      terminator   # split terminal
      tmux         # terminal multiplexer
      zellij       # modern tmux alternative
      lftp         # SFTP/FTP CLI

      btop
    ];
  };
}
