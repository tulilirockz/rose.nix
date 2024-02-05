{pkgs, ...}: let
  apps = import ./apps.nix {inherit pkgs;};
in {
  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    libinput.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = apps.sharedApps;
}
