{
  lib,
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

  home.sessionVariables = rec {
    #GTK2_RC_FILES = lib.mkForce "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    czkawka
    mumble
    audacity
    inkscape
    upscayl
    stremio
    halftone
    krita
    (pkgs.writeScriptBin "xwayland-run" ''
      ${lib.getExe pkgs.xwayland} :0 &
      sleep 2
      DISPLAY=:0 $@ 
    '')
  ];

  programs.obs-studio = {
    enable = false;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture
      obs-gstreamer
      input-overlay
      obs-pipewire-audio-capture
    ];
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

  programs.devtools.enable = true;
  programs.clitools.enable = true;
  programs.wm.enable = true;
  programs.wm.niri.enable = true;
  programs.wm.apps.enable = true;
  programs.browsers.enable = true;

  xdg.configFile."gnome-boxes/sources/QEMU System".text = ''
    [source]
    name=QEMU Session
    type=libvirt
    uri=qemu+unix:///session
    save-on-quit=true
  '';

  dconf.settings = lib.mkMerge [
    (import ../modules/dconf-themes/mine.nix)
    {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///session"];
        uris = ["qemu:///session"];
      };
    }
  ];
}
