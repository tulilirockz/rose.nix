{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.rose.programs.desktops.shared;
in
{
  options.rose.programs.desktops.shared = {
    enable = lib.mkEnableOption "Shared configuration for all desktops";
  };

  config = lib.mkIf cfg.enable {
    rose.programs.collections.shared.enable = true;

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
