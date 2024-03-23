{ config
, lib
, pkgs
, preferences
, ...
}:
let
  cfg = config.programs.managed-desktops;
  valid_desktops = [ "gnome" "plasma" "niri" "wm" "shared" ];
in
{
  options = {
    programs.managed-desktops = lib.mkOption {
      default = { };
      type = lib.types.submodule (_: {
        options = {
          enable = lib.mkEnableOption {
            description = "Enable window manager related configurations";
            example = true;
            default = false;
          };
          shared = lib.mkOption {
            default = { };
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = true;
                  description = "Enable shared";
                };
              };
            });
          };
          wm = lib.mkOption {
            default = { };
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable shared";
                };
              };
            });
          };
          niri = lib.mkOption {
            default = { };
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable niri";
                };
              };
            });
          };
          gnome = lib.mkOption {
            default = { };
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable gnome";
                };
              };
            });
          };
          plasma = lib.mkOption {
            default = { };
            type = lib.types.submodule (_: {
              options = {
                enable = lib.mkEnableOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable plasma";
                };
              };
            });
          };
        };
      });
    };
  };
  config = lib.mkIf cfg.enable (lib.mkMerge (
    map
      (
        module:
        lib.mkIf (cfg.${module}.enable == true) (import ./desktops/${module}.nix {
          inherit pkgs;
          inherit config;
          inherit preferences;
          inherit lib;
        })
      )
      valid_desktops
  ));
}
