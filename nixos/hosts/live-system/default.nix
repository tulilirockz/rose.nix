{ config
, pkgs
, ...
}: {
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  };
  environment.systemPackages = with pkgs; [
    just
    git
    tmux
    vim
  ];
  services.openssh.enable = true;
  time.timeZone = "America/Sao_Paulo";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
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
    firewall.enable = true;
  };
}
