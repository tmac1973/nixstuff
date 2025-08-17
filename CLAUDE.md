# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a NixOS configuration repository with multiple machine configurations and Home Manager setup:

- `asmodean/` - Desktop computer "asmodeus" NixOS configuration using modular flake-based approach
- `geryon/` - Laptop computer "geryon" NixOS configuration (monolithic configuration.nix, rarely updated)
- `homemgr/` - Home Manager configuration for user environment

**Important**: When configuration modifications are requested, assume they refer to the `asmodean` configuration unless explicitly stated otherwise. Always verify the target machine before proceeding with changes.

## Architecture

### Flake-based Configuration (asmodean)
The `asmodean` configuration demonstrates the modern, modular approach:
- `flake.nix` - Defines inputs (stable + unstable nixpkgs) and outputs
- `configuration.nix` - Main entry point importing all modules
- `modules/` directory contains specialized configurations:
  - `system.nix` - Boot, hardware, networking, nix settings
  - `packages.nix` - User account and system packages (stable + unstable)
  - `desktop.nix`, `storage.nix`, `virtualization.nix`, `services.nix` - Feature-specific modules

### Legacy Configuration (geryon)
The `geryon` configuration uses traditional NixOS approach:
- Single `configuration.nix` file with all settings
- Includes laptop-specific optimizations (TLP power management)
- AMD GPU support and hardware imports

### Home Manager
Separate flake for user-level package management and dotfiles:
- `flake.nix` - Home Manager setup
- `home.nix` - User packages (VSCodium, devenv) and program configurations

## Common Development Commands

### NixOS System Management
```bash
# Rebuild system configuration (asmodean)
sudo nixos-rebuild switch --flake ./asmodean#asmodean

# Rebuild system configuration (geryon)
sudo nixos-rebuild switch

# Test configuration without switching
sudo nixos-rebuild test --flake ./asmodean#asmodean

# Update flake inputs
nix flake update ./asmodean
```

### Home Manager
```bash
# Switch to new Home Manager configuration
home-manager switch --flake ./homemgr

# Update Home Manager flake
nix flake update ./homemgr
```

### Package Management
```bash
# Search for packages
nix search nixpkgs package-name

# Format Nix files
alejandra .

# Show flake info
nix flake show ./asmodean
```

## Key Features

### Dual Channel Setup (asmodean)
- Stable packages from nixos-25.05 channel
- Unstable packages available via `pkgs-unstable` (e.g., claude-code)
- Configured in `asmodean/flake.nix:16-21`

### Package Categories
- Development tools: git, gcc, docker, podman
- Desktop environment: KDE Plasma 6 with Wayland
- Media: OBS Studio, Kdenlive, Blender, GIMP
- Gaming: Steam, Bottles, MangoHUD
- Security: 1Password with browser integration

### System Optimizations
- Latest kernel packages
- AMD GPU support (amdgpu drivers)
- Automatic garbage collection (weekly, 7-day retention)
- Store optimization enabled
- Unfree packages allowed globally

## File Modifications

When modifying configurations:
1. For new system packages: Edit `asmodean/modules/packages.nix`
2. For system settings: Use appropriate module in `asmodean/modules/`
3. For user packages: Edit `homemgr/home.nix`
4. Always test changes before switching permanently

The modular structure in `asmodean` makes it easy to locate and modify specific functionality without affecting other system components.