# nvidia.nix
{ config, pkgs, ... }:

{
  hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.prime = {
    sync.enable = true;

    # dedicated
    nvidiaBusId = "PCI:2b:0:0";
  };

}
