{ config, pkgs, ... }:

{
  # NFS support
  boot.supportedFilesystems = ["nfs"];
  services.rpcbind.enable = true;
  
  # Network file systems
  fileSystems."/iso" = {
    device = "truenas.local:/mnt/pool0/isos/template/iso";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
  
  fileSystems."/netstuff" = {
    device = "truenas.local:/mnt/pool0/stuff";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
  
  fileSystems."/netmedia" = {
    device = "truenas.local:/mnt/pool0/media";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}