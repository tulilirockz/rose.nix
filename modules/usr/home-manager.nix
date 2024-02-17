{
  inputs,
  preferences,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home-manager/devtools.nix
    ./home-manager/hyprland.nix 
    ./home-manager/river.nix
    ./home-manager/wm.nix
  ];

  programs.home-manager.enable = true;
  home.username = preferences.main_username;
  home.homeDirectory = "/home/${preferences.main_username}";
  home.stateVersion = "24.05";

  colorScheme = (inputs.nix-colors.lib.contrib {inherit pkgs;}).colorSchemeFromPicture {
    path = ../../assets/lockscreen.png;
    variant = "dark";
  };

  xdg.configFile."libvirt/qemu.conf".text = ''
    nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
  '';
  xdg.userDirs.createDirectories = true;

  home.packages = with pkgs; [
    czkawka
    mumble
    lagrange
    audacity
    inkscape
    cantarell-fonts
    upscayl
    stremio
    halftone
    krita
    fira-code-nerdfont
  ];

  programs.nushell.enable = true;

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      obs-gstreamer
      input-overlay
      obs-pipewire-audio-capture
    ];
  };

  programs.fzf.enable = true;
  programs.fzf.tmux.enableShellIntegration = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableNushellIntegration = true;
  };

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

  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        font = "${preferences.font_family}:size=12";
        shell = pkgs.lib.getExe pkgs.nushell;
        title = "amogus";
        locked-title = true;
        bold-text-in-bright = true;
      };
      environment = {
        "EDITOR" = lib.getExe pkgs.neovim;
      };
      colors = with config.colorScheme.palette; {
        alpha = 0.7;
        background = base00;
        foreground = base05;
      };
    };
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

  programs.nushell.extraEnv = "$env.EDITOR = nvim";
  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };

  programs.devtools.enable = true;

  dconf.settings = import ./home-manager/dconf-themes/mine.nix;
}
