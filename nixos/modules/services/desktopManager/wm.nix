{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.wm;
in
{
  options.rose.services.desktopManager.wm.enable = lib.mkEnableOption "Shared configuration for all WMs";

  config = lib.mkIf cfg.enable {
    rose = {
      programs.wm.enable = true;
      services.desktopManager.shared.enable = true;
      services.displayManager.greetd = {
        enable = true;
        tuigreet.enable = true;
      };
    };

    systemd.user.services.wpaperd = {
      description = "Wallpaper Daemon for Wayland";
      wants = [ "graphical.target" ];
      after = [ "graphical.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.wpaperd}";
        Restart = "on-failure";
        RestartSec = 2;
        TimeoutStopSec = 10;
      };
    };

    #systemd.user.services.mako = {
    #  description = "Notification daemon for wayland";
    #  wantedBy = [ "niri.service" ];
    #  wants = [ "graphical.target" ];
    #  after = [ "graphical.target" ];
    #  serviceConfig = {
    #    Type = "simple";
    #    ExecStart = "${lib.getExe pkgs.mako}";
    #    Restart = "on-failure";
    #    RestartSec = 2;
    #    TimeoutStopSec = 10;
    #  };
    #};

    systemd.user.services.gnome-polkit-agent = {
      description = "PolicyKit Authentication Agent for GNOME/GTK";
      wants = [ "graphical.target" ];
      after = [ "graphical.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    security.polkit.enable = true;

    programs.kdeconnect.enable = true;
    programs.seahorse.enable = true;
    services.gnome.gnome-keyring.enable = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
    xdg.portal.enable = true;
  };
}
