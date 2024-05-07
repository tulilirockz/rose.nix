{ lib, config, ... }:
let
  cfg = config.rose.programs.desktops.gnome;
in
{
  options.rose.programs.desktops.gnome.enable = lib.mkEnableOption "GNOME/GTK Settings";

  config = lib.mkIf cfg.enable {
    dconf.settings = lib.mkMerge [ (import ../modules/dconf-themes/mine.nix) ];
  };
}
