{ pkgs, ... }:
let
  apps = import ./apps.nix { inherit pkgs; };
in
{
  services.xserver = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    displayManager.defaultSession = "plasma";
  };

  programs.kdeconnect.enable = true;
  environment.systemPackages = [ pkgs.plasma-pa ] ++ apps.qtApps;
}
