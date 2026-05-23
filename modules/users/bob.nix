# User definition for bob.
{ ... }:

{
  flake.nixosModules.user-bob = { pkgs, ... }: {

    services.pcscd.enable = true;

    users.users.bob = {
      isNormalUser = true;
      description = "bob";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      packages = with pkgs; [
        kdePackages.kate
        thunderbird
        brave
        discord-ptb
        discord
        pavucontrol
        vscode
        blender
        davinci-resolve
        chatterino2
        gimp3
        wasistlos
        anytype
        element-desktop
        firefox
      ];
    };
  };
}
