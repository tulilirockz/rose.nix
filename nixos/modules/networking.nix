{config, lib, ...}:
let
  cfg = config.rose.networking;
in {
  options.rose.networking = with lib; {
    enable = mkEnableOption "Optionated networking defaults";
    firewall = mkOption {
      type = types.submodule (_: {
        options = {
          enable = mkEnableOption "Firewall w NFTables and rules";
          extraPorts = mkOption {
            type = types.listOf types.port;
            description = "Extra ports open in firewall";
            default = [];
            example = [22 2222];
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
  
    networking = {
      networkmanager.enable = true;
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
