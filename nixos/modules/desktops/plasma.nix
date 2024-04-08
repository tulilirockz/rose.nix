{ lib, config, ... }:
let
  cfg = config.rose.programs.desktops.plasma;
in
{
  options.rose.programs.desktops.plasma = with lib; {
    enable = mkEnableOption "KDE Plasma Desktop";
  };
  config = lib.mkIf cfg.enable {
    rose.programs.collections.qt.enable = true;
    rose.programs.desktops.shared.enable = true;

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
