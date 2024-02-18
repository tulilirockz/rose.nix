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
  programs.nushell.extraConfig = with config.colorScheme.palette; ''

    let base00 = "#${base00}"
    let base01 = "#${base01}"
    let base02 = "#${base02}"
    let base03 = "#${base03}"
    let base04 = "#${base04}"
    let base05 = "#${base05}"
    let base06 = "#${base06}"
    let base07 = "#${base07}"
    let base08 = "#${base08}"
    let base09 = "#${base09}"
    let base0a = "#${base0A}"
    let base0b = "#${base0B}"
    let base0c = "#${base0C}"
    let base0d = "#${base0D}"
    let base0e = "#${base0E}"
    let base0f = "#${base0F}"

      let base16_theme = {
        separator: $base03
        leading_trailing_space_bg: $base04
        header: $base0b
        date: $base0e
        filesize: $base0d
        row_index: $base0c
        bool: $base08
        int: $base0b
        duration: $base08
        range: $base08
        float: $base08
        string: $base04
        nothing: $base08
        binary: $base08
        cellpath: $base08
        hints: dark_gray

        # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
        # but i like the regular white on red for parse errors
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_bool: $base0d
        shape_int: { fg: $base0e attr: b}
        shape_float: { fg: $base0e attr: b}
        shape_range: { fg: $base0a attr: b}
        shape_internalcall: { fg: $base0c attr: b}
        shape_external: $base0c
        shape_externalarg: { fg: $base0b attr: b}
        shape_literal: $base0d
        shape_operator: $base0a
        shape_signature: { fg: $base0b attr: b}
        shape_string: $base0b
        shape_filepath: $base0d
        shape_globpattern: { fg: $base0d attr: b}
        shape_variable: $base0e
        shape_flag: { fg: $base0d attr: b}
        shape_custom: {attr: b}
      }

      $env.config.color_config = $base16_theme
      $env.config.use_grid_icons = true
      $env.config.footer_mode = always #always, never, number_of_rows, auto
      $env.config.float_precision = 2
      $env.config.use_ansi_coloring = true
      $env.config.edit_mode = vi
      $env.config.show_banner = false
  '';
  programs.nushell.extraEnv = "$env.EDITOR = nvim";
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

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };

  programs.devtools.enable = true;

  dconf.settings = import ./home-manager/dconf-themes/mine.nix;
}
