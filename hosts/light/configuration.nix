{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/kde.nix    
    ../../modules/tulili.nix    
    ../../modules/std.nix
  ];

  system.stateVersion = "23.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "light";

  environment.systemPackages = with pkgs; [
    cage
    weston
    distrobox
    waydroid
  ];
  
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
  };
  
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
       turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
