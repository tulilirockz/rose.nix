{ lib, config, ... }:
let
  cfg = config.rose.services.desktopManager.plasma;
in
{
  options.rose.services.desktopManager.plasma.enable = lib.mkEnableOption "KDE Plasma Desktop";

  config = lib.mkIf cfg.enable {
    rose = {
      programs.qt.enable = true;
      services.desktopManager.shared.enable = true;
    };

    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
      displayManager.defaultSession = "plasma";
    };
    programs.kdeconnect.enable = true;
  };
}
