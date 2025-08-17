# Modular NixOS configuration with flakes support
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Modular configuration
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/storage.nix
    ./modules/virtualization.nix
    ./modules/services.nix
    ./modules/packages.nix
  ];
}
