{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.niri;
in
{
  options.rose.services.desktopManager.niri.enable = lib.mkEnableOption "Niri WM";

  config = lib.mkIf cfg.enable {
    rose = {
      programs.wm.enable = true;
      programs.gnome.enable = true;
      services.desktopManager.wm.enable = true;
    };

    niri-flake.cache.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs = {
      niri.package = pkgs.niri-unstable;
      niri.enable = true;
      kdeconnect.enable = true;
    };
  };
}
