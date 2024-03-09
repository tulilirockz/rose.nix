{ pkgs
, lib
, ...
}:
let
  consoleRun = "${pkgs.foot}/bin/footclient -e";
in
[
  {
    mainBar.layer = "top";
    layer = "top";
    position = "left";

    modules-left = [ "network" "pulseaudio" "cpu" "memory" ];
    modules-center = [ "clock" ];
    modules-right = [ "disk" "custom/notification" "tray" "custom/logout" ];

    "clock" = {
      format = "{:%I\n%M}";
      tooltip = true;
      on-click = "${consoleRun} \"${pkgs.peaclock}/bin/peaclock\"";
    };
    "memory" = {
      interval = 5;
      format = "󰍛 {}%";
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
      format = " {percentage_free}%";
      tooltip = true;
      on-click = "${consoleRun} \"${lib.getExe pkgs.btop}\"";
    };
    "network" = {
      format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      format-ethernet = ": {bandwidthDownOctets}\n: {bandwidthUpOctets}";
      format-wifi = "{icon} {signalStrength}%";
      format-disconnected = "󰤮";
      tooltip = false;
      on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    };
    "tray" = {
      spacing = 12;
    };
    "pulseaudio" = {
      format = "{icon} {volume}%\n{format_source}";
      format-bluetooth = "{volume}% {icon}\n{format_source}";
      format-bluetooth-muted = " {icon}\n{format_source}";
      format-muted = "\n{format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
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
      format = "⏻";
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
      format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      on-click = "";
      tooltip = false;
    };
  }
]
