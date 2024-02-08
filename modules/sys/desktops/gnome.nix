{pkgs, ...}: let
  apps = import ./apps.nix {inherit pkgs;};
in {
  imports = [
    ./shared.nix
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.seahorse.enable = true;

  environment.systemPackages =
    (with pkgs.gnomeExtensions; [
      dash-to-dock
      blur-my-shell
      appindicator
      tiling-assistant
    ])
    ++ [pkgs.gnome-randr]
    ++ apps.gnomeApps;

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
