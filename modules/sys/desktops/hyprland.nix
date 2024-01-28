{inputs, pkgs, ...}: let
  apps = import ./apps.nix {inherit pkgs;};
in {
  imports = [
    ./shared.nix
  ];

  services.greetd.enable = true;
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = ../../../assets/lockscreen.png;
        fit = "Contain";
      };
      GTK = {
        application_prefer_dark_theme = true;
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

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  hardware.opengl.enable = true;

  xdg.portal.enable = true;

  environment.systemPackages =
    (with pkgs; [
      (
        pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
      )
      hyprpaper
      wofi
      libnotify
      networkmanagerapplet
      hyprland-protocols
      swaylock-effects
      swayidle
      grimblast
      udiskie
      catppuccin-gtk
    ])
    ++ apps.gnomeApps;
}
