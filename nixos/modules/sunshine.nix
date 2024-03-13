{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.services.sunshine;
  sunshinePort = 47990;
in
{
  options.services.sunshine = {
    enable = lib.mkEnableOption "sunshine";
    package = lib.mkPackageOption pkgs "sunshine" { };
    openFirewall = lib.mkEnableOption "openFirewall";
  };

  config = mkIf cfg.enable {
    systemd.services.sunshine = {
      wantedBy = [ "graphical-session.target" ];
      description = "Sunshine is a Game stream host for Moonlight.";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/sunshine";
        User = "root";
      };
    };

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };

    boot.kernelModules = [ "uinput" ];

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ sunshinePort ];
      allowedUDPPorts = [ sunshinePort ];
    };

    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';
  };
}
