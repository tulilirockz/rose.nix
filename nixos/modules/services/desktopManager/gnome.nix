{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.gnome;
in
{
  options.rose.services.desktopManager.gnome.enable = lib.mkEnableOption "GNOME Desktop";

  config = lib.mkIf cfg.enable {
    rose = {
      programs.gnome.enable = true;
      services.desktopManager.shared.enable = true;
    };

    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.seahorse.enable = true;

    environment.systemPackages =
      (with pkgs.gnomeExtensions; [
        dash-to-dock
        blur-my-shell
        appindicator
        tiling-assistant
      ])
      ++ [ pkgs.gnome-randr ];

    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
        gedit
      ])
      ++ (with pkgs.gnome; [
        cheese
        gnome-music
        gnome-terminal
        epiphany
        geary
        gnome-characters
        tali
        iagno
        hitori
        atomix
      ]);
  };
}
