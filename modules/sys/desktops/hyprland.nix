{pkgs, ...}: {
  imports = [
    ./shared.nix
  ];

  services.xserver.displayManager.gdm.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.opengl.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {NIXOS_OZONE_WL = "1";};

  environment.systemPackages =
    (with pkgs; [
      (
        pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
      )
      mako
      hyprpaper
      wofi
      libnotify
      networkmanagerapplet
      hyprland-protocols
      hyprland-autoname-workspaces
      hyprshade
      hyprnome
      hyprdim
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
      gnome-control-center
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

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
    ])
    ++ (with pkgs.gnome; [
      cheese
      gnome-music
      gnome-terminal
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
    ]);
}
