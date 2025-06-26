# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["amdgpu"];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_6_13;

  boot.extraModprobeConfig = ''
    blacklist nouveau
  '';

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  networking.hostName = "asmodean"; # Define your hostname.

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "tim"];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  boot.supportedFilesystems = ["nfs"];
  services.rpcbind.enable = true;
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  # Enable 3d graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # hardware.nvidia.open = true;
  # hardware.nvidia.powerManagement.enable = false;
  # hardware.nvidia.powerManagement.finegrained = false;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # hardware.nvidia.prime = {
  #   offload.enable = true;

  #   amdgpuBusId = "PCI:10:00:0";
  #   nvidiaBusId = "PCI:11:00:0";
  # };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "tim";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
      # Add other substituters if you use them, e.g., "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      # Add other trusted keys
    ];
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["tim"];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
      '';
      mode = "0755";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    brave
    steam
    git
    curl
    docker
    docker-compose
    kdePackages.plasma-browser-integration
    nvtopPackages.full
    protonplus
    gcc
    yt-dlp
    cifs-utils
    nfs-utils
    obs-studio
    kdePackages.kdenlive
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    blender
    lshw
    mc
    rsync
    alacritty
    alacritty-theme
    vulkan-tools
    pciutils
    r2modman
    nexusmods-app-unfree
    evolution
    cudatoolkit
    pkgs.libreoffice-qt6-fresh
    slack
    pinta
    gimp3-with-plugins
    inkscape-with-extensions
    dysk
    fish
    htop
    btop
    ghostty
    discord
    signal-desktop
    filezilla
    alejandra
    obsidian
    zoom-us
    kdePackages.kjournald
    distrobox
    boxbuddy
    fastfetch
    gpu-screen-recorder # CLI
    gpu-screen-recorder-gtk # GUI
    bottles
    nix-output-monitor
    chromium
    handbrake
    vlc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.docker.enable = true;

  # Enable oci-containers and specify the web-ui container
  # Enable oci-containers and specify the open-webui container

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      open-webui = {
        # Changed container name to open-webui
        image = "ghcr.io/open-webui/open-webui:main"; # Official image for Open WebUI
        ports = [
          "3000:8080" # Map host port 3000 to container port 8080 as per documentation
        ];
        extraOptions = [
          "--restart=always" # Ensure the container restarts with the system
        ];
        volumes = [
          "open-webui:/app/backend/data" # Use a named Docker volume for persistent data
        ];

        # To disable the login page for single-user setup (optional):
        # environment = {
        #   "WEBUI_AUTH" = "False";
        # };
        # Connect to a local Ollama server running on the host:
        environment = {
          "OLLAMA_BASE_URL" = "http://127.0.0.1:11434";
        };
        # For Nvidia GPU support (requires nvidia-container-toolkit setup on NixOS):
        # extraOptions = [
        #   "--gpus=all"
        # ];
      };
    };
  };

  #virtualisation.vmware.host.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  services.avahi = {
    nssmdns4 = true;
    enable = true;
  };

  services.flatpak.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # system.autoUpgrade = {
  #   enable = true;
  #   channel = "https://nixos.org/channels/nixos-25.05";
  # };

  ### clean system
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
