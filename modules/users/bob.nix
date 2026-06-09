# User definition for bob.
{ ... }:

{
  flake.nixosModules.user-bob = { pkgs, ... }: {

    nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (old: {
          doCheck = false;
        });
      })
    ];

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
        karere
        anytype
        element-desktop
        firefox
        ani-cli
      ];
    };
  };
}
