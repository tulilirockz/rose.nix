{pkgs, ...}: let
  apps = import ./apps.nix {inherit pkgs;};
in {
  services.xserver = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma5.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };

  environment.systemPackages = [pkgs.plasma-pa] ++ apps.qtApps;
}
