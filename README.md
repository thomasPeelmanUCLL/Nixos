# Frederick's NixOS Configuration

A modular NixOS system configuration using the **Dendritic Pattern** — built with [`flake-parts`](https://github.com/hercules-ci/flake-parts) and [`import-tree`](https://github.com/vic/import-tree) for automatic module discovery.

## Structure

```
.
├── flake.nix                        # Flake entrypoint (flake-parts + import-tree)
├── flake.lock                       # Locked dependency versions
└── modules/
    ├── hosts/
    │   └── nixos/
    │       ├── default.nix          # Defines nixosConfigurations.nixos
    │       ├── configuration.nix    # Core system config (boot, networking, locale, nix settings)
    │       └── hardware-configuration.nix  # Auto-generated hardware config
    ├── features/
    │   ├── desktop.nix              # KDE Plasma 6 + SDDM + PipeWire
    │   ├── gaming.nix               # Steam, GameMode, Star Citizen, Lutris, Heroic, Bottles
    │   ├── nvidia.nix               # NVIDIA driver (production package)
    │   └── packages.nix             # System-wide CLI tools and utilities
    └── users/
        └── bob.nix                  # User definition for bob
```

## How It Works

Every `.nix` file under `modules/` is automatically imported by `import-tree`. Each file exposes a named `flake.nixosModules.<name>` output, which is then referenced by name in `modules/hosts/nixos/configuration.nix` — no fragile relative path imports.

```nix
# flake.nix
outputs = inputs@{ flake-parts, import-tree, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];
    imports = [ (import-tree ./modules) ];
  };
```

## Inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` | NixOS 25.11 package set |
| `nix-citizen` | Star Citizen / RSI Launcher packaging |
| `flake-parts` | Modular flake structure |
| `import-tree` | Auto-discovers all modules in `modules/` |

## Features

### Desktop
- **KDE Plasma 6** on Wayland via SDDM
- **PipeWire** audio with WirePlumber and PulseAudio compatibility
- **KDE Connect**, dconf, printing enabled
- Belgian keyboard layout (`be`)

### Gaming
- **Steam** with remote play and Gamescope session
- **Star Citizen** via [`nix-citizen`](https://github.com/LovingMelody/nix-citizen) (cachix-cached)
- **GameMode** for CPU/GPU performance boost
- **MangoHud**, ProtonUp-NG, Lutris, Heroic, Bottles
- `vm.max_map_count` and `fs.file-max` tuned for Star Citizen

### NVIDIA
- Production driver package via `config.boot.kernelPackages.nvidiaPackages.production`
- Modesetting enabled, 32-bit graphics support
- `GBM_BACKEND=nvidia-drm` and `__GLX_VENDOR_LIBRARY_NAME=nvidia` set for Wayland

### System
- Weekly auto-upgrades, daily GC (deletes generations older than 10 days)
- Nix store auto-optimisation
- Flakes and nix-command experimental features enabled

## Rebuilding

```bash
# Standard rebuild
sudo nixos-rebuild switch

# Using nh (faster, shows diff)
nh os switch /etc/nixos
```

## Adding a New Module

1. Create a new `.nix` file anywhere under `modules/`
2. Wrap your config in a named output:
   ```nix
   { ... }:
   {
     flake.nixosModules.my-feature = { pkgs, ... }: {
       # your NixOS config here
     };
   }
   ```
3. Add `self.nixosModules.my-feature` to the imports list in `modules/hosts/nixos/configuration.nix`
4. Run `sudo nixos-rebuild switch`
