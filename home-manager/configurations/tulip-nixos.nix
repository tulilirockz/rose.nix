{
  preferences,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../modules.nix
  ];

  programs.home-manager.enable = true;
  home.username = preferences.main_username;
  home.homeDirectory = "/home/${preferences.main_username}";
  home.stateVersion = "24.05";
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  home.sessionVariables = rec {
    #GTK2_RC_FILES = lib.mkForce "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
  };
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

  programs.devtools.enable = true;
  programs.clitools.enable = true;
  programs.wm.enable = true;
  programs.wm.hyprland.enable = true;
  programs.wm.river.enable = true;
  programs.wm.apps.enable = true;

  dconf.settings = import ../modules/dconf-themes/mine.nix;
}
