# System-wide packages.
{ ... }:

{
  flake.nixosModules.packages = { pkgs, ... }: {

    programs.winbox = {
      enable = true;
      openFirewall = true; # Required for auto-discovering MikroTik routers
    };

    services.udev.packages = [ pkgs.openrazer-daemon ];
    hardware.openrazer.enable = true;
    
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
      nixfmt

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

      termius

      easyeffects

      traceroute
      tcpdump
      wireshark

      # ryzer
      polychromatic
    ];
  };
}
