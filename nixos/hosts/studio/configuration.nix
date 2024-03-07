{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/managed-desktops.nix
    ../../modules/std.nix
    ../../modules/sunshine.nix
    ../../modules/virtual.nix
    ../../modules/user.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader.systemd-boot.enable = true;
  };
  networking.hostName = "studio";

  programs.managed-desktops.enable = true; 
  programs.managed-desktops.shared.enable = true; 
  programs.managed-desktops.wm.enable = true; 
  programs.managed-desktops.niri.enable = true; 

  virtualisation.managed.enable = true;
  
  environment.systemPackages = with pkgs; [heroic];
  programs.steam.enable = false;
  
  programs.sunshine.enable = false;
}
