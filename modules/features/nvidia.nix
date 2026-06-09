# NVIDIA driver configuration.
{ ... }:

{
  flake.nixosModules.nvidia = { config, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;

      powerManagement.enable = true; # Prevents GPU clock from dropping mid-game
      powerManagement.finegrained = false;     # Keep clocks stable during gaming


    };
  };
}
