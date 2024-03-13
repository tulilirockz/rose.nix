{ lib
, preferences
, pkgs
, config
, inputs
, ...
}: {
  imports = [
    ../modules/browsers.nix
    ../modules/clitools.nix
    ../modules/devtools.nix
    ../modules/impermanence.nix
    ../modules/wm.nix
  ];

  colorScheme =
    if (preferences.theme.colorSchemeFromWallpaper)
    then
      (inputs.nix-colors.lib.contrib { inherit pkgs; }).colorSchemeFromPicture
        {
          path = preferences.theme.wallpaperPath;
          variant = preferences.theme.type;
        }
    else inputs.nix-colors.colorSchemes.${preferences.theme.name};

  programs.home-manager.enable = true;
  home.username = preferences.username;
  home.homeDirectory = "/home/${preferences.username}";
  home.stateVersion = "24.05";

  home.sessionVariables = rec {
    #GTK2_RC_FILES = lib.mkForce "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
    TLDR_CACHE_DIR = "${XDG_CACHE_HOME}/tldr";
    CARGO_HOME = "${XDG_CACHE_HOME}/cargo";
    DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
    HISTFILE = "${XDG_STATE_HOME}/bash/history";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.fuchsia-cursor;
    name = "Fuchsia";
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture
      obs-gstreamer
      input-overlay
      obs-pipewire-audio-capture
    ];
  };

  programs.devtools.enable = true;
  programs.clitools.enable = true;
  programs.wm.enable = true;
  programs.wm.plasma.enable = false;
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
        autoconnect = [ "qemu:///session" ];
        uris = [ "qemu:///session" ];
      };
    }
  ];
}
