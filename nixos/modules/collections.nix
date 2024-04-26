{ lib, config, pkgs, ... }:
let
  cfg = config.rose.programs.collections;
in
{
  options.rose.programs.collections = with lib; {
    enable = mkEnableOption "App Collections";
    gnome = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "GNOME apps (gtk)";
      });
    };
    wm = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "WM apps";
      });
    };
    shared = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Programs for any DE";
      });
    };
    qt = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "QT apps";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with lib.lists; with pkgs; (
      (optionals cfg.qt.enable
        (with libsForQt5; [
          kclock
          alligator
          kamoso
          kasts
          kolourpaint
          kweather
        ] ++ [
          qpwgraph
          vlc
          keepassxc
          qbittorrent
        ])
      ) ++
      (optionals cfg.gnome.enable
        (with gnome; [
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
          polari
        ]
        ++
        [
          shortwave
          gitg
          transmission-gtk
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
        ])
      ) ++
      (optionals cfg.wm.enable [
        wlay
        blueman
        mpv
        zathura
        wl-clipboard
        transmission-gtk
        gnome.nautilus
        swayimg
      ]) ++
      (optionals cfg.shared.enable [
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
        mpv
        nodePackages.webtorrent-cli
        mpvScripts.mpv-cheatsheet
        mpvScripts.webtorrent-mpv-hook
      ])
    );
  };
}
