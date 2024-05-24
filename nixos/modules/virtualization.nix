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
          (optionals config.virtualisation.podman.enable (with pkgs; [ buildah ]))
          ++ (optionals cfg.gui.enable [
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
            OVMF
            
            skopeo
            distrobox
            debootstrap
            arch-install-scripts
            dnf5
            (writeScriptBin "dnf" "${lib.getExe pkgs.dnf5} $@")
            apk-tools
            pacman
            rpm           
            bubblewrap
            proot
            lilipod
          ]
        );

      environment.etc."libvirt/qemu.conf".text = ''
        nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
      '';
      environment.etc."qemu/firmware/default.json".source = pkgs.writers.writeJSON "default.json" {
        description = "UEFI firmware for x86_64";
        interface-types = [ "uefi" ];
        mapping = {
          device = "flash";
          executable = {
            filename = "${pkgs.OVMF.fd}/FV/OVMF_CODE.fd";
            format = "raw";
          };
          nvram-template = {
            filename = "${pkgs.OVMF.fd}/FV/OVMF_VARS.fd";
            format = "raw";
          };
        };
        targets = [
          {
            architecture = "x86_64";
            machines = [
              "pc-i440fx-*"
              "pc-q35-*"
            ];
          }
        ];
        features = [
          "acpi-s3"
          "amd-sev"
          "verbose-dynamic"
        ];
        tags = [ ];
      };
      virtualisation = rec {
        podman = {
          enable = !(docker.rootless.enable);
          autoPrune.enable = true;
          dockerSocket.enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        containers.containersConf.settings = {
          engine = {
            runtime = "${pkgs.crun}/bin/crun";
          };
        };
        docker.rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings = {
            default-runtime = "crun";
            runtimes = {
              crun = {
                path = pkgs.crun;
              };
            };
          };
        };
        libvirtd = {
          enable = true;
          qemu.swtpm.enable = true;
        };
        vmware.host.enable = (cfg.gui.enable && cfg.unfree.enable);
      };
    };
}
