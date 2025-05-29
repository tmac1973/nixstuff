{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    jetbrains.pycharm-community-bin
    go
    cargo
    vscodium
    uv
    poetry
    
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #	".ssh/allowed_signers".text =
    #	    "* ${builtins.readFile /home/tim/.ssh/id_ed25519.pub}";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tim/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userName = "Tim MacDonald";
    userEmail = "tbaxmacdonald@gmail.com";
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      #        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
