{pkgs, ...}: {
  imports = [
    ./shared.nix
  ];

  services.xserver.displayManager.gdm.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
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
      hyprland-autoname-workspaces
      swaylock-effects
      swayidle
      grimblast
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
