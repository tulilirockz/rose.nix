{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.wayfire;
in
{
  options.rose.services.desktopManager.wayfire.enable = lib.mkEnableOption "Wayfire WM";

  config = lib.mkIf cfg.enable {
    rose = {
      services.desktopManager.wm.enable = true;
      programs.wm.enable = true;
      programs.shared.enable = true;
    };

    xdg.portal.wlr.settings = {
      screencast = {
        output_name = "HDMI-A-1";
        max_fps = 75;
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [ wayfire-plugins-extra ];
    };
  };
}
