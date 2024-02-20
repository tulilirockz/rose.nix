{
  pkgs,
  lib,
  ...
}: let
  consoleRun = "${pkgs.foot}/bin/footclient -e";
in [
  {
    layer = "top";
    position = "top";

    modules-left = ["network" "pulseaudio" "cpu" "memory" "disk" "clock"];
    modules-right = ["custom/notification" "custom/logout" "tray"];

    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        default = " ";
        active = " ";
        urgent = " ";
      };
    };
    "clock" = {
      format = "{: %I:%M %p}";
      tooltip = false;
      on-click = "${consoleRun} \"${pkgs.peaclock}/bin/peaclock\"";
    };
    "hyprland/window" = {
      max-length = 60;
      separate-outputs = false;
    };
    "memory" = {
      interval = 5;
      format = "🐏{}%";
      tooltip = true;
      on-click = "${consoleRun} \"${lib.getExe pkgs.btop}\"";
    };
    "cpu" = {
      interval = 5;
      format = " {usage:2}%";
      tooltip = true;
      on-click = "${consoleRun} \"${lib.getExe pkgs.btop}\"";
    };
    "disk" = {
      format = "  {free}";
      tooltip = true;
      on-click = "${consoleRun} \"${lib.getExe pkgs.btop}\"";
    };
    "network" = {
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      format-ethernet = ": {bandwidthDownOctets} : {bandwidthUpOctets}";
      format-wifi = "{icon} {signalStrength}%";
      format-disconnected = "󰤮";
      tooltip = false;
      on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    };
    "tray" = {
      spacing = 12;
    };
    "pulseaudio" = {
      format = "{icon} {volume}% {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "${lib.getExe pkgs.pavucontrol}";
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} {}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
      on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -op";
      escape = true;
    };
    "custom/logout" = {
      tooltip = false;
      format = "🔒";
      on-click = "${lib.getExe pkgs.wlogout}";
    };
    "battery" = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = "󱘖 {capacity}%";
      format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      on-click = "";
      tooltip = false;
    };
  }
]
