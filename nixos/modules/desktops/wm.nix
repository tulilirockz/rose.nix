{ preferences, pkgs, lib, config, ... }:
let
  cfg = config.rose.programs.desktops.wm;
in
{
  options.rose.programs.desktops.wm = {
    enable = lib.mkEnableOption "Shared configuration for all WMs";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.collections.wm.enable = true;
    services.greetd.enable = true;
    programs.regreet = {
      enable = true;
      settings = {
        background = {
          path = preferences.theme.wallpaperPath;
          fit = "Fill";
        };
        GTK = {
          application_prefer_dark_theme = preferences.theme.type == "dark";
          cursor_theme_name = preferences.theme.cursor.name;
          font_name = "${preferences.theme.fontFamily} 12";
          icon_theme_name = preferences.theme.icon.name;
          theme_name = "Catppuccin-Frappe-Standard-Blue-Dark";
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
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    xdg.portal.enable = true;

    xdg.mime.defaultApplications = {
      "image/png" = "swayimg.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };
}
