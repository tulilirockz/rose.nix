{
  pkgs,
  preferences,
  ...
}: let
  apps = import ./apps.nix {inherit pkgs;};
in {
  services.greetd.enable = true;
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = preferences.wallpaper;
        fit = "Fill";
      };
      GTK = {
        application_prefer_dark_theme = preferences.theme_type == "dark";
        cursor_theme_name = "Bibata-Modern-Classic";
        font_name = "Cantarell 12";
        icon_theme_name = "Adwaita";
        theme_name = "Catppuccin-Frappe-Standard-Blue-Dark";
      };
    };
  };
  programs.seahorse.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.swaylock.text = "auth include login";
  services.gnome.gnome-keyring.enable = true;

  hardware.opengl.enable = true;
  xdg.portal.enable = true;

  xdg.mime.defaultApplications = {
    "image/png" = "swayimg.desktop";
    "application/pdf" = "zathura.desktop";
  };

  environment.systemPackages =
    apps.wmApps
    ++ apps.gnomeApps;
}
