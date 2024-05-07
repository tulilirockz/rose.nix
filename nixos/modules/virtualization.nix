{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.rose.virtualization;
in
{
  options.rose.virtualization = with lib; {
    enable = mkEnableOption "virtualization options";
    unfree = mkOption {
      default = { };
      description = "Allow unfree configurations to be enabled";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Unfree Virtualization Technologies";
      });
    };
    gui = mkOption {
      default = { };
      description = "GUI virtualization applications or related";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Gui Virtualization Apps";
      });
    };
  };

  config =
    with lib;
    mkIf cfg.enable {
      rose.system.unfree.extraPredicates = lib.mkIf cfg.unfree.enable [
        "vmware-workstation"
        "vmware-player"
      ];

      programs.virt-manager.enable = cfg.gui.enable;
      environment.systemPackages =
        with lib.lists;
        with pkgs;
        (
          (optionals cfg.gui.enable [
            virt-viewer
            gnome.gnome-boxes
          ])
          ++ [
            virglrenderer
            quickemu
            nerdctl
            lazydocker
            kubernetes-helm
            kind
            docker-buildx
            cilium-cli
            devpod
            kubectl
            talosctl
            firecracker
            firectl
            inputs.nuspawn.packages.${pkgs.system}.nuspawn
            skopeo
          ]
        );

      virtualisation = rec {
        podman = {
          enable = !(docker.rootless.enable);
          autoPrune.enable = true;
          dockerSocket.enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        docker.rootless = {
          enable = true;
          setSocketVariable = true;
        };
        libvirtd = {
          enable = true;
          qemu.swtpm.enable = true;
        };
        vmware.host.enable = (cfg.gui.enable && cfg.unfree.enable);
      };
    };
}
