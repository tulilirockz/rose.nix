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
