{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.sway;
in
{
  options.rose.services.desktopManager.sway.enable = lib.mkEnableOption "Sway WM";

  config = lib.mkIf cfg.enable {
    rose = {
      services.desktopManager.shared.enable = true;
      programs = {
        wm.enable = true;
        shared.enable = true;
      };
    };

    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
    };
  };
}
