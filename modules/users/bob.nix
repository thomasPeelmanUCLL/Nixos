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

  nixpkgs.overlays = [
  (final: _prev: {
    pnpm_10_29_2 = final.pnpm_10;  # redirects to latest patched pnpm 10.x
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
        vesktop
        pavucontrol
        vscode
        blender
        davinci-resolve
        chatterino2
        gimp3
        anytype
        element-desktop
        firefox
      ];
    };
  };
}
