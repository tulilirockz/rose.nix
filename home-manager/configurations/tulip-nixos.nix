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
    ../modules/creation.nix
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

  programs = {
    home-manager.enable = true;
    devtools.enable = true;
    clitools.enable = true;
    browsers.enable = true;
    browsers.extras = true;
    wm = {
      enable = true;
      ${preferences.desktop}.enable = true;
      apps.enable = true;
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
      DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    };
  };


  systemd.user.services."rclone@webui" = {
    Unit = {
      Description = "Rclone Web UI";
      Documentation = "man:rclone(1)";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe pkgs.rclone} rcd --rc-web-gui";
    };
  };

  systemd.user.services."rclone@gdrive" = {
    Unit = {
      Description = "Rclone Mounting for Google Drive";
      Documentation = "man:rclone(1)";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe (pkgs.writers.writeNuBin "rclone-gdrive" 
        ''
          mkdir $"($env.HOME)/Google Drive"          
          ${lib.getExe pkgs.rclone} mount gdrive: $"($env.HOME)/Google Drive" --vfs-cache-mode full
        ''
      )}";
    };
  };

  systemd.user.services."rclone@onedrive" = {
    Unit = {
      Description = "Rclone Mounting for OneDrive";
      Documentation = "man:rclone(1)";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe (pkgs.writers.writeNuBin "rclone-onedrive" 
        ''
          mkdir $"($env.HOME)/OneDrive"
          ${lib.getExe pkgs.rclone} mount onedrive: $"($env.HOME)/OneDrive" --vfs-cache-mode full
        ''
        )}";
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

  programs.creation.enable = true;

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
