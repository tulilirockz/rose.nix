{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
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
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    gedit
    epiphany
    geary
    gnome-characters
    tali
    iagno
    hitori
    atomix
  ]);

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
