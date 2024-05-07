{
  config,
  lib,
  preferences,
  ...
}:
let
  cfg = config.rose.hardware;
in
{
  options.rose.hardware = with lib; {
    enable = mkEnableOption "Enable common hardware options";
    general = mkOption {
      default = { };
      description = "General hardware definitions for my computers";
      type = lib.types.submodule (_: {
        options.enable = lib.mkEnableOption "General Hardware Thingies";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    zramSwap.enable = true;
    zramSwap.memoryPercent = 75;

    services.automatic-timezoned.enable = true;
    i18n.defaultLocale = preferences.locale;

    hardware = {
      bluetooth.enable = true;
      opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };
    };

    services = {
      printing.enable = true;
      system76-scheduler.enable = true;
      fwupd.enable = true;
    };
  };
}
