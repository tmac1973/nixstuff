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

  # 1Password browser integration (needs to be in main config for flake compatibility)
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
      '';
      mode = "0755";
    };
  };
}
