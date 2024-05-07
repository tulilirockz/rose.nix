{
  preferences,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.programs.desktops.wm;
in
{
  options.rose.programs.desktops.wm = {
    enable = lib.mkEnableOption "Shared configuration for all WMs";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.collections.wm.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.lib.getExe (
            pkgs.writeScriptBin "niri-session-script" ''
              XDG_SESSION_TYPE=wayland ${pkgs.niri}/bin/niri-session
            ''
          )}";
          user = "greeter";
        };
      };
    };
    programs.seahorse.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.swaylock.text = "auth include login";
    services.gnome.gnome-keyring.enable = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
    xdg.portal.enable = true;

    xdg.mime.defaultApplications = {
      "image/png" = "swayimg.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };
}
