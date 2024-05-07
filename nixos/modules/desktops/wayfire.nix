{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.programs.desktops.wayfire;
in
{
  options.rose.programs.desktops.wayfire = {
    enable = lib.mkEnableOption "Wayfire WM";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;
    rose.programs.desktops.shared.enable = true;

    xdg.portal.xdgOpenUsePortal = true;
    xdg.portal.wlr.settings = {
      screencast = {
        output_name = "HDMI-A-1";
        max_fps = 75;
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    programs.kdeconnect.enable = true;
    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [ wayfire-plugins-extra ];
    };
  };
}
