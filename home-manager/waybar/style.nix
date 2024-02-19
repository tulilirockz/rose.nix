{config, ...}:
with config.colorScheme.palette; let
  left_bubble = "15px 50px 15px 50px";
  right_bubble = "50px 15px 50px 15px";
in ''
  * {
    font-size: 16px;
    font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
    font-weight: bold;
  }
  window#waybar {
    background-color: rgba(26,27,38,0);
    border-bottom: 1px solid rgba(26,27,38,0);
    border-radius: 0px;
    color: #${base05};
  }
  #workspaces {
    background: linear-gradient(180deg, #${base00}, #${base01});
    margin: 5px;
    padding: 0px 1px;
    border-radius: 15px;
    border: 0px;
    font-style: normal;
    color: #${base05};
  }
  #workspaces button {
    padding: 0px 5px;
    margin: 4px 3px;
    border-radius: 15px;
    border: 0px;
    color: #${base05};
    background-color: #${base05};
    opacity: 1.0;
    transition: all 0.3s ease-in-out;
  }
  #workspaces button.active {
    color: #${base05};
    background: #${base04};
    border-radius: 15px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
    opacity: 1.0;
  }
  #workspaces button:hover {
    color: #${base05};
    background: #${base04};
    border-radius: 15px;
    opacity: 1.0;
  }
  tooltip {
    background: #${base00};
    border: 1px solid #${base04};
    border-radius: 10px;
  }
  tooltip label {
    color: #${base05};
  }
  #window {
    color: #${base05};
    background: #${base00};
    border-radius: 0px 15px 50px 0px;
    margin: 5px 5px 5px 0px;
    padding: 2px 20px;
  }
  #memory {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #clock {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #cpu {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #disk {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #battery {
    color: #${base05};
    background: #${base00};
    border-radius: 15px;
    margin: 5px;
    padding: 2px 20px;
  }
  #network {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #tray {
    color: #${base05};
    background: #${base00};
    border-radius: 15px 0px 0px 50px;
    margin: 5px 0px 5px 5px;
    padding: 2px 20px;
  }
  #pulseaudio {
    color: #${base05};
    background: #${base00};
    border-radius: ${right_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #custom-notification {
    color: #${base05};
    background: #${base00};
    border-radius: ${left_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
  #custom-themeselector {
    color: #${base05};
    background: transparent;
    border-radius: 5px;
    margin: 5px;
    padding: 2px 2px;
  }
  #custom-logout {
    color: #${base05};
    background: #${base00};
    border-radius: ${left_bubble};
    margin: 5px;
    padding: 2px 20px;
  }
''
