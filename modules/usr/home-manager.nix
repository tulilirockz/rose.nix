{pkgs, ...}: {
  imports = [
    ./home-manager/dconf-theme.nix
    ./home-manager/managed-neovim.nix
  ];

  programs.home-manager.enable = true;
  home.username = "tulili";
  home.homeDirectory = "/home/tulili";
  home.stateVersion = "24.05";

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
    extraConfig = (pkgs.lib.concatMapStringsSep "\n" (string: string) [
      "set -sg escape-time 10"
      "set -g @thumbs-osc52 1"
      "set-window-option -g mode-keys vi"
      "bind-key -T copy-mode-vi v send-keys -X begin-selection"
      "bind-key -T copy-mode-vi C-v send-keys -X rectangle toggle"
      "bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel"
    ]) + "\n" +
    (pkgs.lib.concatMapStringsSep "\n" (plugin: "set -g @plugin ${plugin}") [ 
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
    };
    scrolling = {
      history = 10000;
    };
    shell = { 
      program = "${pkgs.lib.getExe pkgs.bash}";
      args = [ "--login" "-c" "tmux attach -2 || tmux -2" ];
    };
    # Catppuccin Mocha theme
    colors = {
      primary = {  
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        dim_foreground = "#CDD6F4";
        bright_foreground = "#CDD6F4";
      };
      cursor = {
        text = "#1E1E2E";
        cursor = "#F5E0DC";
      };
      vi_mode_cursor = {
        text = "#1E1E2E";
        cursor = "#B4BEFE";
      };
      search = {
        matches = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
        focused_match = {
          foreground = "#1E1E2E";
          background = "#A6E3A1";
        };
      };
      footer_bar = {
        foreground = "#1E1E2E";
        background = "#A6ADC8";
      };
      hints = {
        start = {
          foreground = "#1E1E2E";
          background = "#F9E2AF";
        };
        end = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
      };
      selection = {
        text = "#1E1E2E";
        background = "#F5E0DC";
      };
      normal = {
        black = "#45475A";
        red = "#F38BA8";
        green = "#A6E3A1";
        yellow = "#F9E2AF";
        blue = "#89B4FA";
        magenta = "#F5C2E7";
        cyan = "#94E2D5";
        white = "#BAC2DE";
      };
      bright = {
        black = "#585B70";
        red = "#F38BA8";
        green = "#A6E3A1";
        yellow = "#F9E2AF";
        blue = "#89B4FA";
        magenta = "#F5C2E7";
        cyan = "#94E2D5";
        white = "#A6ADC8";
      };
      dim = {
        black = "#45475A";
        red = "#F38BA8";
        green = "#A6E3A1";
        yellow = "#F9E2AF";
        blue = "#89B4FA";
        magenta = "#F5C2E7";
        cyan = "#94E2D5";
        white = "#BAC2DE";
      };
      indexed_colors = [ 
        {
          index = 16;
          color = "#FAB387";
        } 
        {
          index = 17;
          color = "#F5E0DC";
        }
      ];
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
