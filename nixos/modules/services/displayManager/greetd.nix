{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.rose.services.displayManager.greetd;
in
{
  options.rose.services.displayManager.greetd = with lib; {
    enable = mkEnableOption "GreetD based greeters";
    tuigreet = mkOption {
      default = { };
      description = "TuiGreet greeter";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Wheter to enable TuiGreet";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = lib.mkIf cfg.tuigreet.enable {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --greeting 'Thank you for helping us help you help us all.' --remember --remember-session --asterisks --power-shutdown '${pkgs.systemd}/bin/systemctl poweroff' --power-reboot '${pkgs.systemd}/bin/systemctl reboot' --power-no-setsid --width 140 --theme border=magenta;text=magenta;prompt=lightmagenta;time=magenta;action=lightmagenta;button=magenta;container=gray;input=magenta --cmd ${pkgs.lib.getExe (
            pkgs.writeScriptBin "niri-session-script" ''
              XDG_SESSION_TYPE=wayland ${pkgs.niri}/bin/niri-session
            ''
          )}";
          user = "greeter";
        };
      };
    };
  };
}
