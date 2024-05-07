{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.rose.programs;
in
{
  options.rose.programs = with lib; {
    enable = mkEnableOption "App Collections";
    gnome = mkOption {
      default = { };
      description = "Any GNOME(Circle) apps";
      type = types.submodule (_: {
        options.enable = mkEnableOption "GNOME apps (gtk)";
      });
    };
    wm = mkOption {
      default = { };
      description = "Programs for Window Manager environments, usually TUI apps";
      type = types.submodule (_: {
        options.enable = mkEnableOption "WM apps";
      });
    };
    shared = mkOption {
      default = { };
      description = "Programs for Any DE";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Programs for any DE";
      });
    };
    qt = mkOption {
      default = { };
      description = "Any KDE apps";
      type = types.submodule (_: {
        options.enable = mkEnableOption "QT apps";
      });
    };
    cosmic = mkOption {
      default = { };
      description = "Any COSMIC Epoch apps";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Cosmic apps";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      with lib.lists;
      with pkgs;
      (
        (optionals cfg.qt.enable (
          with libsForQt5;
          [
            kclock
            alligator
            kamoso
            kasts
            kolourpaint
            kweather
          ]
          ++ [
            qpwgraph
            vlc
            keepassxc
            qbittorrent
          ]
        ))
        ++ (optionals cfg.gnome.enable (
          with gnome;
          [
            gnome-tweaks
            dconf-editor
            nautilus
            totem
            sushi
            gnome-weather
            gnome-calendar
            gnome-clocks
            gnome-calculator
            gnome-system-monitor
            gnome-tweaks
            dconf-editor
          ]
          ++ [
            shortwave
            gitg
            fragments
            gnome-solanum
            gitg
            gradience
            impression
            amberol
            baobab
            blanket
            snapshot
            loupe
            gnome-firmware
            gnome-podcasts
            newsflash
            fractal
            folio
            rnote
            drawing
            endeavour
            rnote
            iotas
          ]
        ))
        ++ (optionals cfg.wm.enable [
          wlay
          blueman
          mpv
          zathura
          wl-clipboard
          gnome.nautilus
          swayimg
        ])
        ++ (optionals cfg.shared.enable [
          cinny-desktop
          thunderbird
          adw-gtk3
          helvum
          pavucontrol
          libreoffice
          catppuccin-gtk
          mumble
          gnome-podcasts
          newsflash
          thunderbird
          monophony
          shortwave
          keepassxc
          localsend
          gnome.gnome-clocks
          bitwarden-cli
          mpv
          nodePackages.webtorrent-cli
          mpvScripts.mpv-cheatsheet
          mpvScripts.webtorrent-mpv-hook
        ])
        ++ (optionals cfg.cosmic.enable [
          cosmic-files
          cosmic-edit
          cosmic-tasks
          cosmic-icons
        ])
      );
  };
}
