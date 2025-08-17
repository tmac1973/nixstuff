{ config, pkgs, ... }:

{
  # Graphics and display
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Desktop environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Keymap configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Flatpak
  services.flatpak.enable = true;
}