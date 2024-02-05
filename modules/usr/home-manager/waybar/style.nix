{config, ...}: 
with config.colorScheme.palette; ''
* {
  font-size: 16px;
  font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
  font-weight: bold;
}
window#waybar {
  background-color: rgba(26,27,38,0);
  border-bottom: 1px solid rgba(26,27,38,0);
  border-radius: 0px;
  color: #${base0F};
}
#workspaces {
  background: linear-gradient(180deg, #${base00}, #${base01});
  margin: 5px;
  padding: 0px 1px;
  border-radius: 15px;
  border: 0px;
  font-style: normal;
  color: #${base00};
}
#workspaces button {
  padding: 0px 5px;
  margin: 4px 3px;
  border-radius: 15px;
  border: 0px;
  color: #${base00};
  background-color: #${base00};
  opacity: 1.0;
  transition: all 0.3s ease-in-out;
}
#workspaces button.active {
  color: #${base00};
  background: #${base04};
  border-radius: 15px;
  min-width: 40px;
  transition: all 0.3s ease-in-out;
  opacity: 1.0;
}
#workspaces button:hover {
  color: #${base00};
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
  color: #${base07};
}
#window {
  color: #${base05};
  background: #${base00};
  border-radius: 0px 15px 50px 0px;
  margin: 5px 5px 5px 0px;
  padding: 2px 20px;
}
#memory {
  color: #${base0F};
  background: #${base00};
  border-radius: 15px 50px 15px 50px;
  margin: 5px;
  padding: 2px 20px;
}
#clock {
  color: #${base0B};
  background: #${base00};
  border-radius: 15px 50px 15px 50px;
  margin: 5px;
  padding: 2px 20px;
}
#cpu {
  color: #${base07};
  background: #${base00};
  border-radius: 50px 15px 50px 15px;
  margin: 5px;
  padding: 2px 20px;
}
#disk {
  color: #${base07};
  background: #${base00};
  border-radius: 15px 50px 15px 50px;
  margin: 5px;
  padding: 2px 20px;
}
#battery {
  color: #${base08};
  background: #${base00};
  border-radius: 15px;
  margin: 5px;
  padding: 2px 20px;
}
#network {
  color: #${base09};
  background: #${base00};
  border-radius: 50px 15px 50px 15px;
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
  color: #${base0D};
  background: #${base00};
  border-radius: 50px 15px 50px 15px;
  margin: 5px;
  padding: 2px 20px;
}
#custom-notification {
  color: #${base0C};
  background: #${base00};
  border-radius: 15px 50px 15px 50px;
  margin: 5px;
  padding: 2px 20px;
}
#custom-themeselector {
  color: #${base0D};
  background: transparent;
  border-radius: 5px;
  margin: 5px;
  padding: 2px 2px;
}
#custom-logout {
  color: #${base0C};
  background: #${base00};
  border-radius: 15px 50px 15px 50px;
  margin: 5px;
  padding: 2px 20px;
}
''
