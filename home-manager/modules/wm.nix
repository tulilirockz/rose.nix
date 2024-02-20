{
  config,
  lib,
  pkgs,
  preferences,
  ...
}: let
  cfg = config.programs.wm;
  contents = lib.mkMerge (
    builtins.map (
      module:
        lib.mkIf (cfg.${module}.enable == true) (import ./wm/${module}.nix {
          inherit pkgs;
          inherit config;
          inherit preferences;
          inherit lib;
        })
    ) ["apps" "hyprland" "river"]
  );
in {
  options = {
    programs.wm = lib.mkOption {
      default = {};
      type = lib.types.submodule (_: {
        options = {
          enable = lib.mkEnableOption {
            description = "Enable window manager related configurations";
            example = true;
            default = false;
          };
          apps = lib.mkOption {
            default = {};
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = true;
                  description = "Enable wm-based apps";
                };
              };
            });
          };
          hyprland = lib.mkOption {
            default = {};
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = true;
                  description = "Enable hyprland managed configuration";
                };
              };
            });
          };
          river = lib.mkOption {
            default = {};
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = true;
                  description = "Enable river managed configuration";
                };
              };
            });
          };
        };
      });
    };
  };
  config = lib.mkIf cfg.enable contents;
}
