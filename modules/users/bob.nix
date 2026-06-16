# User definition for bob.
{ ... }:

{
  flake.nixosModules.user-bob = { pkgs, ... }: {

    # In modules/users/bob.nix — replace both discord entries in the overlay
    nixpkgs.overlays = [
      (final: prev: {
        discord = prev.discord.override {
          commandLineArgs = "--disable-features=MediaFoundationH264Encoding,HardwareMediaKeyHandling";
        };
        discord-ptb = prev.discord-ptb.override {
          commandLineArgs = "--disable-features=MediaFoundationH264Encoding,HardwareMediaKeyHandling";
        };

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
