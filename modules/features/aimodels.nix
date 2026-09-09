{ pkgs, ... }:

{
  flake.nixosModules.aimodels = { pkgs, ... }: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;

      loadModels = [
        "qwen2.5-coder:7b"
        "llama3.2:3b"
        "qwen2.5-coder:14b"
      ];
    };

    environment.systemPackages = [
      pkgs.ollama-cuda
      pkgs.nodejs_22
    ];

    systemd.services.anytype-mcp = {
      description = "Anytype MCP server";
      after = [ "network.target" ];
      wants = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = "bob";
        Group = "users";
        ExecStart = "/etc/anytype-mcp/run.sh";
        Restart = "on-failure";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}