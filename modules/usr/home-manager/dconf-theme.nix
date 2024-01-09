{
  config,
  lib,
  ...
}: let
  cfg = config.programs.dconf-theme;
in {
  options = {
    programs.dconf-theme.enable = lib.mkEnableOption {
      description = "Enable this module";
      example = true;
      default = false;
    };
    programs.dconf-theme.theme = lib.mkOption {
      default = "";
      example = "ubuntu";
      type = with lib.types; enum ["ubuntu" "mine"];
      description = "Select a predefined DConf theme for GNOME";
    };
  };
  config = lib.mkIf cfg.enable {
    dconf.settings = import ./dconf-themes/${cfg.theme}.nix;
  };
}
