{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.rose.programs.ags;
in
{
  options.rose.programs.ags = with lib; rec {
    enable = mkEnableOption "AGS shell";
    package = mkOption {
      type = types.package;
      example = pkgs.ags;
      description = "Package for AGS";
      default = (
        pkgs.ags.overrideAttrs (
          finalAttrs: oldAttrs: { buildInputs = oldAttrs.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ]; }
        )
      );
    };
    extraLibraries = mkOption {
      type = with types; listOf package;
      default = [ ];
      example = [ pkgs.libdbusmenu-gtk3 ];
      description = "Required libraries and packages for your custom AGS setup";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file."${config.home.homeDirectory}/.config/ags" = {
      source = ./ags-config;
      recursive = true;
    };
  };
}
