{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.rose.programs.desktops.niri;
in
{
  options.rose.programs.desktops.niri = {
    enable = lib.mkEnableOption "Niri WM";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;
    rose.programs.desktops.shared.enable = true;
    niri-flake.cache.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.enable = true;
    programs.kdeconnect.enable = true;
  };
}
