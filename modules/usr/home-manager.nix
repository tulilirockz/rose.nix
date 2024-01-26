{
  inputs,
  main_username,
  user_wallpaper,
  theme,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home-manager/dconf-theme.nix
    ./home-manager/managed-neovim.nix
    (import ./home-manager/hyprland.nix { 
      inherit pkgs;
      inherit config;
      inherit user_wallpaper;
      inherit lib;
    })
  ];

  programs.home-manager.enable = true;
  home.username = main_username;
  home.homeDirectory = "/home/${main_username}";
  home.stateVersion = "24.05";

  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  xdg.userDirs.createDirectories = true;

  home.packages = with pkgs; [
    gnumake
    lazygit
    darcs
    unzip
    just
    git
    tmux
    ollama
    buildah
    gh
    glab
    wl-clipboard
    fd
    ripgrep
    nixos-generators
    podman-compose
    docker-compose
    tldr
    manix
    fira-code-nerdfont
    mumble
    catppuccin-gtk
    cantarell-fonts
  ];

  programs.fish.enable = false;
  programs.nushell.enable = true;

  programs.fzf.enable = true;
  programs.fzf.tmux.enableShellIntegration = true;

  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
    mouse = true;
    secureSocket = true;
    clock24 = true;
    newSession = true;
    terminal = "xterm-256color";
    keyMode = "vi";
    tmuxp.enable = true;
    extraConfig =
      (pkgs.lib.concatMapStringsSep "\n" (string: string) [
        "set -sg escape-time 10"
        "set -g @thumbs-osc52 1"
        "set-window-option -g mode-keys vi"
        "bind-key -T copy-mode-vi v send-keys -X begin-selection"
        "bind-key -T copy-mode-vi C-v send-keys -X rectangle toggle"
        "bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel"
      ])
      + "\n"
      + (pkgs.lib.concatMapStringsSep "\n" (plugin: "set -g @plugin ${plugin}") [
        "catppuccin/tmux-mocha"
        "christoomey/vim-tmux-navigator"
      ]);
    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      tmux-thumbs
      catppuccin
      sensible
      vim-tmux-navigator
    ];
  };

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      decorations = "Full";
      title = "Amogus";
      opacity = 0.8;
      dynamic_title = true;
    };
    scrolling = {
      history = 10000;
    };
    font = {
      normal.family = "FiraCode Nerd Font Mono";
      bold.family = config.programs.alacritty.settings.font.normal.family;
      italic.family = config.programs.alacritty.settings.font.normal.family;
      bold_italic.family = config.programs.alacritty.settings.font.normal.family;
    };
    #shell = {
    #  program = "${pkgs.lib.getExe pkgs.bash}";
    #  args = [ "--login" "-c" "tmux attach -2 || tmux -2" ];
    #};
    # Catppuccin Mocha theme
    colors = import ./home-manager/alacritty/catppuccin.nix;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  home.file = {
    ".gitconfig".source = ./home-manager/dotfiles/gitconfig;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };

  programs.dconf-theme.enable = true;
  programs.dconf-theme.theme = "mine";
  programs.managed-neovim.enable = true;

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "daily";
  };
  services.flatpak.packages = [
    "com.obsproject.Studio"
    "com.bitwarden.desktop"
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "com.rafaelmardojai.Blanket"
    "io.github.flattool.Warehouse"
    "io.podman_desktop.PodmanDesktop"
    "net.lutris.Lutris"
    "org.audacityteam.Audacity"
    "org.chromium.Chromium"
    "org.gnome.Epiphany"
    "org.gnome.Firmware"
    "org.godotengine.Godot"
    "org.inkscape.Inkscape"
    "org.kde.krita"
    "org.onlyoffice.desktopeditors"
  ];
}
