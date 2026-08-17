{ ... }:

{
  flake.nixosModules.aimodels = {pkgs, ...}: {
    services.ollama = {
    enable = true;
    acceleration = "cuda";

    loadModels = [
      "qwen2.5-coder:7b"
      "llama3.2:3b"
    ];
  };
  };
}
