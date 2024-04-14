{ lib, config, pkgs, ... }:
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

  config = with lib; mkIf cfg.enable {
    systemd.user.services."${rclone_prefix}@webui" = mkIf cfg.webui.enable {
      Unit = {
        Description = "Rclone Web UI";
        Documentation = "man:rclone(1)";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${getExe cfg.package} rcd --rc-web-gui";
      };
    };

    systemd.user.services."${rclone_prefix}@gdrive" = mkIf cfg.gdrive.enable {
      Unit = {
        Description = "Rclone Mounting for Google Drive";
        Documentation = "man:rclone(1)";
      };
      Install = {
        WantedBy = [ "network.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${getExe (pkgs.writers.writeNuBin "rclone-gdrive" 
          ''
            mkdir $"${cfg.gdrive.mountPath}"         
            ${getExe cfg.package} mount gdrive: $"${cfg.onedrive.mountPath}" --vfs-cache-mode full
          ''
        )}";
      };
    };

    systemd.user.services."${rclone_prefix}@onedrive" = mkIf cfg.onedrive.enable {
      Unit = {
        Description = "Rclone Mounting for OneDrive";
        Documentation = "man:rclone(1)";
      };
      Install = {
        WantedBy = [ "network.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${getExe (pkgs.writers.writeNuBin "rclone-onedrive" 
          ''
            mkdir $"${cfg.onedrive.mountPath}"
            ${getExe cfg.package} mount onedrive: $"${cfg.onedrive.mountPath}" --vfs-cache-mode full
          ''
          )}";
      };
    };
  };
}
