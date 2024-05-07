{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.rose.services.rclone;
  rclone_prefix = "rclone";
in
{
  options.rose.services.rclone = with lib; {
    enable = mkEnableOption "Rclone";
    package = mkPackageOption pkgs "rclone" { };
    onedrive = mkOption {
      type = types.submodule (_: {
        options = {
          enable = mkEnableOption "Onedrive";
          mountPath = mkOption {
            default = "($env.HOME)/OneDrive";
            type = types.str;
            description = "Mount Path for OneDrive";
          };
        };
      });
    };
    gdrive = mkOption {
      type = types.submodule (_: {
        options = {
          enable = mkEnableOption "Google Drive";
          mountPath = mkOption {
            default = "($env.HOME)/Drive";
            type = types.str;
            description = "Mount Path for Google Drive";
          };
        };
      });
    };
    webui = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "WebUI";
      });
    };
  };

  config =
    lib.mkIf cfg.enable {
      systemd.user.services."${rclone_prefix}@webui" = lib.mkIf cfg.webui.enable {
        unitConfig = {
          Description = "Rclone Web UI";
          Documentation = "man:rclone(1)";
        };
        wantedBy = [ "default.target" ];
        serviceConfig = {
          type = "exec";
          execStart = "${lib.getExe cfg.package} rcd --rc-web-gui";
        };
      };

      systemd.user.services."${rclone_prefix}@gdrive" = lib.mkIf cfg.gdrive.enable {
        unitConfig = {
          Description = "Rclone Mounting for Google Drive";
          Documentation = "man:rclone(1)";
        };
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          type = "exec";
          script = "${lib.getExe cfg.package} mount gdrive: ${cfg.gdrive.mountPath}";
        };
      };

      systemd.user.services."${rclone_prefix}@onedrive" = lib.mkIf cfg.onedrive.enable {
        unitConfig = {
          Description = "Rclone Mounting for OneDrive";
          Documentation = "man:rclone(1)";
        };
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          type = "exec";
          script = "${lib.getExe cfg.package} mount onedrive: ${cfg.onedrive.mountPath}";
        };
      };
    };
}
