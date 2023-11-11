{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;
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
    qpwgraph
    vlc
  ];
  
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    okular
    oxygen
    plasma-browser-integration
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
