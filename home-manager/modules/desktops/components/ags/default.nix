{ lib, config, pkgs, ... }:
let
  cfg = config.rose.programs.desktops.ags;
in
{
  options.rose.programs.desktops.ags = with lib; {
    enable = mkEnableOption "AGS shell";
    package = mkOption {
      type = types.package;
      example = pkgs.ags;
      description = "Custom package for AGS";
      default = (pkgs.ags.overrideAttrs (finalAttrs: oldAttrs: { buildInputs = oldAttrs.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ]; }));
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    home.file."${config.home.homeDirectory}/.config/ags" = {
      source = ./config;
      recursive = true;
    };
  };
}
