{ pkgs, ... }:

{
  imports = [
    ./shared.nix
  ];

  services.xserver = {    
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma5.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };

  environment.systemPackages = with pkgs; [
    plasma-pa
    libsForQt5.kclock
    libsForQt5.alligator
    libsForQt5.kamoso
    libsForQt5.kasts
    libsForQt5.kolourpaint
    libsForQt5.kweather
    qpwgraph
    vlc
    keepassxc
    qbittorrent
  ];
}
