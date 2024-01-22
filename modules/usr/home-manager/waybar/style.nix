{config, ...}: ''
    * {
    		font-size: 16px;
    		font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
        		font-weight: bold;
    	}
    	window#waybar {
    		    background-color: rgba(26,27,38,0);
        		border-bottom: 1px solid rgba(26,27,38,0);
        		border-radius: 0px;
    		    color: #${config.colorScheme.colors.base0F};
    	}
    	#workspaces {
    		background: linear-gradient(180deg, #${config.colorScheme.colors.base00}, #${config.colorScheme.colors.base01});
        		margin: 5px;
        		padding: 0px 1px;
        		border-radius: 15px;
        		border: 0px;
        		font-style: normal;
        		color: #${config.colorScheme.colors.base00};
    	}
    	#workspaces button {
        		padding: 0px 5px;
        		margin: 4px 3px;
        		border-radius: 15px;
        		border: 0px;
        		color: #${config.colorScheme.colors.base00};
        		background-color: #${config.colorScheme.colors.base00};
        		opacity: 1.0;
        		transition: all 0.3s ease-in-out;
    	}
    	#workspaces button.active {
        		color: #${config.colorScheme.colors.base00};
        		background: #${config.colorScheme.colors.base04};
        		border-radius: 15px;
        		min-width: 40px;
        		transition: all 0.3s ease-in-out;
        		opacity: 1.0;
    	}
    	#workspaces button:hover {
        		color: #${config.colorScheme.colors.base00};
        		background: #${config.colorScheme.colors.base04};
        		border-radius: 15px;
        		opacity: 1.0;
    	}
    	tooltip {
      		background: #${config.colorScheme.colors.base00};
      		border: 1px solid #${config.colorScheme.colors.base04};
      		border-radius: 10px;
    	}
    	tooltip label {
      		color: #${config.colorScheme.colors.base07};
    	}
    	#window {
        		color: #${config.colorScheme.colors.base05};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 0px 15px 50px 0px;
        		margin: 5px 5px 5px 0px;
        		padding: 2px 20px;
    	}
    	#memory {
        		color: #${config.colorScheme.colors.base0F};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 50px 15px 50px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#clock {
        		color: #${config.colorScheme.colors.base0B};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 50px 15px 50px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#cpu {
        		color: #${config.colorScheme.colors.base07};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 50px 15px 50px 15px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#disk {
        		color: #${config.colorScheme.colors.base03};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 50px 15px 50px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#battery {
        		color: #${config.colorScheme.colors.base08};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#network {
        		color: #${config.colorScheme.colors.base09};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 50px 15px 50px 15px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#tray {
        		color: #${config.colorScheme.colors.base05};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 0px 0px 50px;
        		margin: 5px 0px 5px 5px;
        		padding: 2px 20px;
    	}
    	#pulseaudio {
        		color: #${config.colorScheme.colors.base0D};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 50px 15px 50px 15px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
    	#custom-notification {
        		color: #${config.colorScheme.colors.base0C};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 50px 15px 50px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
        #custom-themeselector {
        		color: #${config.colorScheme.colors.base0D};
        		background: transparent;
        		border-radius: 5px;
        		margin: 5px;
        		padding: 2px 2px;
                }
  #custom-logout {
        		color: #${config.colorScheme.colors.base0C};
        		background: #${config.colorScheme.colors.base00};
        		border-radius: 15px 50px 15px 50px;
        		margin: 5px;
        		padding: 2px 20px;
    	}
''
