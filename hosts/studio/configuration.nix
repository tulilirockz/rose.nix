{ config, lib, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./desktop.nix
    ./home-n-manager.nix
  ];

  system.stateVersion = "23.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  networking.hostName = "studio";
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
    virt-manager
    cage
    distrobox
    waydroid
    just
    git
    tmux
    nixos-generators 
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
    virtualbox.host.enable = true;
    libvirtd.enable = true;
    vmware.host.enable = true;
  };
  programs.virt-manager.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
