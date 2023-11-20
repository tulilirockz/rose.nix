{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
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
  
  programs.dconf.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
