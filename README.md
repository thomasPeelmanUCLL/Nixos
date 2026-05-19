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

# Using nh (recommended — shows colored diff before switching)
nh os switch /etc/nixos

# Dry run — see what would change without applying it
nh os switch /etc/nixos --dry

# Set NH_FLAKE so you never need to type the path
export NH_FLAKE=/etc/nixos
nh os switch
```

## Maintenance

```bash
# Update all flake inputs to latest
nix flake update

# Update a single input (e.g. just nixpkgs)
nix flake update nixpkgs

# Clean up old generations, keep last 3
nh clean all --keep 3

# See all generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Roll back to previous generation
sudo nixos-rebuild switch --rollback

# Or boot into a specific generation from the bootloader menu (GRUB/systemd-boot)
# — hold Space on boot to see the generation list
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
4. Run `nh os switch /etc/nixos`

## Adding a New Host

The Dendritic Pattern makes multi-machine setups easy — each host picks which modules to compose.

1. Create `modules/hosts/<hostname>/` with `default.nix`, `configuration.nix`, and `hardware-configuration.nix`
2. In `default.nix`, define `flake.nixosConfigurations.<hostname>`
3. In `configuration.nix`, import only the modules relevant to that machine (e.g. skip `gaming.nix` on a laptop)
4. Generate hardware config on the target machine:
   ```bash
   nixos-generate-config --show-hardware-config
   ```
5. Deploy:
   ```bash
   # Locally on the new machine
   sudo nixos-rebuild switch --flake /etc/nixos#hostname

   # Remotely from this machine
   nixos-rebuild switch --flake .#hostname --target-host bob@192.168.1.x
   ```

## Troubleshooting

**`error: attribute 'X' missing` on rebuild**
Usually means a module arg (`inputs`, `system`, `pkgs`) isn't being passed through. Check that `specialArgs = { inherit inputs; system = ...; }` is set in the host's `default.nix` and that the module declares the arg explicitly: `{ pkgs, inputs, system, ... }`.

**`error: expected a list but found a set`**
`import-tree` returns a single module (attrset). Wrap it in a list: `imports = [ (import-tree ./modules) ]`.

**RSI Launcher fails with D3D/ANGLE error**
The embedded Chromium is trying to use Direct3D on Linux. Make sure these are set in `sessionVariables`:
```nix
ANGLE_DEFAULT_PLATFORM = "gl";
EGL_PLATFORM = "wayland";
```
Then log out and back in so the session vars take effect.

**`--delete-older-then` vs `--delete-older-than`**
NixOS silently ignores the malformed flag. The correct spelling is `--delete-older-than` in `nix.gc.options`.

**Diverged git history after remote edits**
```bash
git pull --rebase
git push
# Set as default to avoid this in future:
git config --global pull.rebase true
```
