{
  preferences,
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [ ../modules ];

  programs.home-manager.enable = true;

  colorScheme =
    if (preferences.theme.colorSchemeFromWallpaper) then
      (inputs.nix-colors.lib.contrib { inherit pkgs; }).colorSchemeFromPicture {
        path = preferences.theme.wallpaperPath;
        variant = preferences.theme.type;
      }
    else
      inputs.nix-colors.colorSchemes.${preferences.theme.name};

  rose = {
    home.impermanence.enable = true;
    programs = {
      tools = {
        dev.enable = true;
        dev.gui.enable = true;
        dev.impermanence.enable = true;
        creation.enable = true;
        creation.impermanence.enable = true;
      };
      browsers = {
        enable = true;
        extras.enable = true;
        impermanence.enable = true;
      };
      desktops.${preferences.desktop}.enable = true;
    };
    services.rclone = {
      enable = true;
      webui.enable = false;
      gdrive.enable = false;
      onedrive.enable = true;
    };
  };

  home = {
    username = preferences.username;
    homeDirectory = "/home/${preferences.username}";
    stateVersion = "24.05";

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.fuchsia-cursor;
      name = preferences.theme.cursor.name;
      size = 16;
    };

    sessionVariables = rec {
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
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = preferences.theme.gtk.name;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = preferences.theme.icon.name;
    };
  };

  xdg.configFile."gnome-boxes/sources/QEMU System".text = ''
    [source]
    name=QEMU Session
    type=libvirt
    uri=qemu+unix:///session
    save-on-quit=true
  '';

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///session" ];
      uris = [ "qemu:///session" ];
    };
  };
}
