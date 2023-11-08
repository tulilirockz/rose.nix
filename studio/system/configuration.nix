# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  networking.hostName = "studio";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tulili = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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
  ];

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
    virtualbox.host.enable = true;
  };
  services.flatpak.enable = true;
  zramSwap.enable = true;

  # KDE Plasma -- [
  services.xserver = {
    enable = true;
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

  services.xserver.libinput.enable = true;
  # ]

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
