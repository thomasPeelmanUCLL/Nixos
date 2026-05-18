# users/bob.nix
{ pkgs, ... }:

{
  users.users.bob = {
    isNormalUser = true;
    description = "bob";
    extraGroups = [ "networkmanager" "wheel" "video"];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      brave
      discord-ptb
      discord
      pavucontrol
      vscode
      blender
    ];
  };
}
