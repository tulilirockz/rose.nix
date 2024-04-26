{ config, lib, ... }:
let
  cfg = config.rose.networking;
  networkConfig = {
    DHCP = "yes"; DNSSEC = "yes"; DNSOverTLS = "yes"; DNS = [ "1.1.1.1" "1.0.0.1" ]; 
  };
in
{
  options.rose.networking = with lib; {
    enable = mkEnableOption "Optionated networking defaults";
    firewall = mkOption {
      type = types.submodule (_: {
        options = {
          enable = mkEnableOption "Firewall w NFTables and rules";
          extraPorts = mkOption {
            type = types.listOf types.port;
            description = "Extra ports open in firewall";
            default = [ ];
            example = [ 22 2222 ];
          };
        };
      });
    };

    tailscale = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable Tailscale";
      });
    };

    ipfs = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable recommended IPFS program";
      });
    };

    wireless = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable stuff if using Wifi";
      });
    };

    networkManager = mkEnableOption "Use NetworkManager";
  };

  config = with lib; mkIf cfg.enable {
    services.tailscale = mkIf cfg.tailscale.enable {
      enable = true;
      useRoutingFeatures = "client";
    };

    services.kubo = mkIf cfg.ipfs.enable {
      enable = true;
      enableGC = true;
    };

    systemd.network = {
      enable = !cfg.networkManager;
      wait-online.enable = true;
      networks = {
         "40-wired" = {
            enable = true;
            matchConfig.Name = "en*";
            inherit networkConfig;
            dhcpV4Config.RouteMetric = 1024;
         };
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


    networking.useNetworkd = !cfg.networkManager;
    networking.useDHCP = cfg.networkManager;

    networking = {
      networkmanager.enable = cfg.networkManager;
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
      nftables.enable = false;
      firewall = {
        enable = false;
        allowedUDPPorts = [
          51413 # Transmission
          24800 # Input Leap
        ] ++ cfg.extraPorts;
        allowedTCPPorts = [
          51413 # Transmission
          24800 # Input Leap
        ] ++ cfg.extraPorts;
        extraInputRules = ''
          ip saddr 192.168.0.0/24 accept
        '';
      };
    };
  };
}
