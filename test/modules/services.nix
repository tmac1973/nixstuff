{ config, pkgs, ... }:

{
  # SSH
  services.openssh.enable = true;
  
  # AI/ML services
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  # Network discovery
  services.avahi = {
    nssmdns4 = true;
    enable = true;
  };
}