# User definition for bob.
{ ... }:

{
  flake.nixosModules.user-bob = { pkgs, ... }: {

    /*
    systemd.user.services.easyeffects = {
      description = "EasyEffects audio effects";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
        Restart = "on-failure";
      };
    };
    */

    services.pcscd.enable = true;



    users.users.bob = {
      isNormalUser = true;
      description = "bob";
      extraGroups = [ "networkmanager" "wheel" "video" "openrazer" "docker" ];
      packages = with pkgs; [
        kdePackages.kate
        thunderbird
        brave
        pavucontrol
        vscode
        blender
        davinci-resolve
        chatterino2
        gimp3
        anytype
        element-desktop
        firefox
        jetbrains.datagrip
      ];
    };
  };
}
