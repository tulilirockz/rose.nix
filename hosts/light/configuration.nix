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
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  zramSwap.enable = true;
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "12:00";
    randomizedDelaySec = "45min";
  };
  networking.firewall.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  environment.systemPackages = with pkgs; [
    cage
    weston
    distrobox
    waydroid
    home-manager
  ];
  services.flatpak.enable = true;
  
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
