{ config, pkgs, ... }:
{
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  environment.systemPackages = with pkgs; [
    just
    git
    gnumake
    tmux
    vim
  ];
  services.openssh.enable = true;
  networking = {
    hostName = "live-system";
    wireless.enable = false;
    networkmanager.enable = true;
  };
  time.timeZone = "America/Sao_Paulo";
}

