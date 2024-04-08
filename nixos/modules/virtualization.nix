{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.rose.virtualization;
in
{
  options.rose.virtualization = with lib; {
    enable = mkEnableOption "virtualization options";
    gui = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Gui Virtualization Apps";
      });
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) ["vmware-workstation" "vmware-player"];

    environment.systemPackages = with lib.lists; with pkgs; (
      (optionals cfg.gui.enable [
        virt-viewer
        gnome.gnome-boxes
      ]) ++ [
        virglrenderer
        quickemu
      ]
    );  

    virtualisation = {
      podman = {
        enable = true;
        autoPrune.enable = true;
        dockerSocket.enable = !(config.virtualisation.docker.enable);
        dockerCompat = !(config.virtualisation.docker.enable);
        defaultNetwork.settings.dns_enabled = true;
      };
      docker.enable = true;
      waydroid.enable = cfg.gui.enable;
      libvirtd.enable = true;
      incus.enable = true;
      #vmware.host.enable = cfg.gui.enable;
    };

    programs.virt-manager.enable = cfg.gui.enable;
  };
}
