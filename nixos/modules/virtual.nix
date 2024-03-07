{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.virtualisation.managed;
in {
  options.virtualisation.managed = {
    enable = lib.mkEnableOption "virtual";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      gnome.gnome-boxes
      quickemu
      quickgui
      (pkgs.writeScriptBin "vm-manager" ''
        set -euo pipefail
        VMS_FOLDER=$HOME/opt/vms
        mkdir -p $VMS_FOLDER
        PWD=$VMS_FOLDER ${lib.getExe pkgs.quickgui} 
      '')
    ];

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        autoPrune.enable = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      waydroid.enable = true;
      libvirtd.enable = true;
      incus.enable = true;
    };

    programs.virt-manager.enable = true;
  };
}
