{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.services.desktopManager.shared;
in
{
  options.rose.services.desktopManager.shared.enable = lib.mkEnableOption "Shared configuration for all desktops";

  config = lib.mkIf cfg.enable {
    rose.programs.shared.enable = true;

    xdg = {
      terminal-exec.enable = true;
      portal.xdgOpenUsePortal = true;
    };
    services.libinput.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    programs.dconf.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
    };

    fonts.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "IntelOneMono"
        ];
      })
      cantarell-fonts
      inter
      fira-code-nerdfont
    ];
  };
}
