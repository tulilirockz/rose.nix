{pkgs, ...}: {
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
    xwayland.enable = true;
  };

  hardware.opengl.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-hyprland];

  environment.sessionVariables = {NIXOS_OZONE_WL = "1";};

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
    ])
    ++ (with pkgs; [
      inter
      adw-gtk3
      gradience
      gnome-podcasts
      newsflash
      transmission-gtk
      gnome-solanum
      gitg
      amberol
      nautilus-open-any-terminal
      baobab
      blanket
      audacity
      helvum
      snapshot
      gnome-firmware
      pavucontrol
      loupe
      catppuccin-gtk
      cantarell-fonts
    ])
    ++ (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
      nautilus
      totem
      sushi
      gnome-weather
      gnome-clocks
      gnome-calendar
      gnome-calculator
      gnome-system-monitor
    ]);
}
