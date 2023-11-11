{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;
  
  xdg.portal.enable = true;
  xdg.portal.lxqt.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager.lxqt.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qpwgraph
    vlc
  ];
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
