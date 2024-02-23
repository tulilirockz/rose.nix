{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];
  boot = {
    extraModulePackages = [config.boot.kernelPackages.rtl8192eu];
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };
  environment.systemPackages = with pkgs; [
    just
    git
    tmux
    vim
  ];
  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  time.timeZone = "America/Sao_Paulo";
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking = {
    hostName = "minimal";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.enable = pkgs.lib.mkForce false;
    wireless.iwd.enable = true;
    wireless.iwd.settings = {
      Network = {
        EnableIPV6 = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    firewall.enable = false;
  };
}
