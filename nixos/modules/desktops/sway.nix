{ pkgs, lib, config, ... }:
let
  cfg = config.rose.programs.desktops.sway;
in
{
  options.rose.programs.desktops.sway = {
    enable = lib.mkEnableOption "Sway WM";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;
    rose.programs.desktops.shared.enable = true;
    programs.kdeconnect.enable = true;

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
