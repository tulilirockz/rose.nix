{ pkgs, ... }:

{
  imports = [
    ./shared.nix
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      inter
      adw-gtk3
      gradience
      gnome-podcasts
      newsflash
      transmission-gtk
      gnome-solanum
      gitg
      amberol
    ])
    ++
    (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
    ])
    ++
    (with pkgs.gnomeExtensions; [
      dash-to-dock
      blur-my-shell
      appindicator
      tiling-assistant
    ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
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
