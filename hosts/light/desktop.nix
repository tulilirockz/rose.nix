{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;
  
  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
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
