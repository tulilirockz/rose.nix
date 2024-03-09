{pkgs, preferences, ...}:
with preferences.colorScheme.palette; let 
  defaultPadding = "5px 5px";
  highlightBorder = "border-right: 4px solid #${base01};";
  defaultModuleConfig = moduleName: ''
    ${moduleName} {
      color: #${base05};
      background: #${base00};
      padding: ${defaultPadding};
      ${highlightBorder} 
    }
  '';
in ''
  * {
    font-size: 18px;
    font-family: ${preferences.font_family}, Font Awesome, sans-serif;
    font-weight: bold;
    background: #${base00};
  }
  window#waybar {
    color: #${base05};
  }
  tooltip {
    background: #${base00};
    border: 1px solid #${base04};
  }
  tooltip label {
    color: #${base05};
  }
  #clock {
    font-size: 24px;
    color: #${base05};
    background: #${base00};
    padding: ${defaultPadding};
    ${highlightBorder} 
  }
'' + pkgs.lib.concatMapStringsSep "\n" (string: defaultModuleConfig string) [
  "#custom-logout" "#custom-notification" "#pulseaudio" "#tray" "#network" "#battery" "#disk" "#cpu" "#memory" "#wireless" "#bluetooth"
]
