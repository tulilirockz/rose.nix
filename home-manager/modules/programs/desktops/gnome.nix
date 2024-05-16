{ lib, config, ... }:
let
  cfg = config.rose.programs.desktops.gnome;
in
{
  options.rose.programs.desktops.gnome.enable = lib.mkEnableOption "GNOME/GTK Settings";

  config = lib.mkIf cfg.enable {
    dconf.settings = import ./dconf/mine.nix;
  };
}
