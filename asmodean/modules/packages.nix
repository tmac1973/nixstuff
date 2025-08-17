{ config, pkgs, pkgs-unstable, ... }:

{
  # User configuration
  users.users.tim = {
    isNormalUser = true;
    description = "tim";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Program configurations
  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["tim"];
  };

  # 1Password browser integration
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
      '';
      mode = "0755";
    };
  };

  # System packages - stable versions
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
    blender-hip
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
    cpu-x
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
    logseq
    zoom-us
    kdePackages.kjournald
    distrobox
    boxbuddy
    fastfetch
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    bottles
    nix-output-monitor
    chromium
    handbrake
    vlc
    unrar
    rar
    mangohud
    muse
    lmms
    stress
    s-tui
    waveterm
    dive
    podman-tui
    docker-compose
  ] ++ [
    # Packages from unstable
    pkgs-unstable.claude-code
  ];
}