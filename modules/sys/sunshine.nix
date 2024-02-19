{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.sunshine;
  sunshinePort = 47990;
in {
  options.programs.sunshine = {
    enable = lib.mkEnableOption "sunshine";

    package = lib.mkPackageOption pkgs "sunshine" {};
  };

  config = mkIf cfg.enable {
    systemd.services.sunshine = {
      wantedBy = ["graphical-session.target"];
      description = "Sunshine is a Game stream host for Moonlight.";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/sunshine";
        User = "root";
      };
    };

    networking.firewall = {
      allowedTCPPorts = [sunshinePort];
      allowedUDPPorts = [sunshinePort];
    };

    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';
  };
}
