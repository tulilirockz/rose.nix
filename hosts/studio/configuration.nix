{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  networking.hostName = "studio";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  users.users.tulili = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };
  users.extraGroups.vboxusers.members = [ "tulili" ];
  
  environment.systemPackages = with pkgs; [
    vim
    virt-manager
    onedrive
    cage
    weston
    distrobox
    plasma-pa
    waydroid
    neovim
    yadm
    devbox
    podman-compose
    docker-compose
    just
    git
    tmux
    nerdfonts
    vscode
    nixos-generators 
    home-manager
  ];

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


  services.flatpak.enable = true;
  zramSwap.enable = true;
  
  hardware.pulseaudio.enable = false;
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };

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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "12:00";
    randomizedDelaySec = "45min";
  };
  networking.firewall.enable = true;
  
  system.stateVersion = "23.11";
}
