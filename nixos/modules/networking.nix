{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.rose.networking;
  networkConfig = {
    DHCP = "yes";
    DNSSEC = "yes";
    DNSOverTLS = "yes";
    DNS = [
      "1.1.1.1"
      "1.0.0.1"
      "10.128.0.15"
    ];
  };
in
{
  options.rose.networking = with lib; {
    enable = mkEnableOption "Optionated networking defaults";
    firewall = mkOption {
      default = { };
      description = "Firewall configuration for a Desktop NixOS system";
      type = types.submodule (_: {
        options = {
          enable = mkEnableOption "Firewall w NFTables and rules";
          extraPorts = mkOption {
            default = { };
            description = "Open extra ports for the firewall definitions";
            type = types.submodule (_: {
              options = {
                udp = mkOption {
                  type = types.listOf types.port;
                  description = "Extra ports open in firewall";
                  default = [ ];
                  example = [
                    22
                    2222
                  ];
                };

                tcp = mkOption {
                  type = types.listOf types.port;
                  description = "Extra ports open in firewall";
                  default = [ ];
                  example = [
                    22
                    2222
                  ];
                };
              };
            });
          };
        };
      });
    };

    tailscale = mkOption {
      default = { };
      description = "VPN software for P2P-like communication";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable Tailscale";
      });
    };

    hosts = mkOption {
      default = { };
      description = "Very strict host files for safe web usage";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable strict hosts file";
      });
    };

    wireless = mkOption {
      default = { };
      description = "Wireless drivers and required definitions for Wi-Fi usage";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable stuff if using Wifi";
      });
    };

    networkManager = mkOption {
      default = { };
      description = "Use the NetworkManager service to manage networks (boo)";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Use NetworkManager";
      });
    };
  };

  config =
    with lib;
    mkIf cfg.enable {
      services.tailscale = mkIf cfg.tailscale.enable {
        enable = true;
        useRoutingFeatures = "client";
      };

      systemd.network = {
        enable = !cfg.networkManager.enable;
        networks = {
          # "40-wired" = {
          #   enable = true;
          #   matchConfig.Name = "en*";
          #   inherit networkConfig;
          #   dhcpV4Config.RouteMetric = 1024;
          # };
          "40-wireless" = {
            enable = true;
            matchConfig.Name = "wl*";
            inherit networkConfig;
            dhcpV4Config.RouteMetric = 2048;
          };
        };
      };

      services.resolved = {
        enable = true;
        dnssec = "true";
        dnsovertls = "true";
      };

      networking.useNetworkd = !cfg.networkManager.enable;
      networking.useDHCP = cfg.networkManager.enable;

      networking = {
        networkmanager.enable = cfg.networkManager.enable;
        networkmanager.wifi.backend = "iwd";
        wireless.iwd.enable = cfg.wireless.enable;
        wireless.iwd.settings = mkIf cfg.wireless.enable {
          Network = {
            EnableIPV6 = true;
          };
          Settings = {
            AutoConnect = true;
          };
        };
        nftables.enable = true;
        firewall = {
          enable = cfg.firewall.enable;
          allowedUDPPorts = [
            51413 # Transmission
            24800 # Input Leap
          ] ++ cfg.firewall.extraPorts.udp;
          allowedTCPPorts = [
            51413 # Transmission
            24800 # Input Leap
          ] ++ cfg.firewall.extraPorts.tcp;
          extraInputRules = ''
            ip saddr 192.168.0.0/24 accept
          '';
        };
        extraHosts = lib.mkIf (cfg.hosts.enable) (builtins.readFile inputs.unified-hosts-strict.outPath);
      };
    };
}
