{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.rose.programs.tools.creation;
in
{
  options.rose.programs.tools.creation = with lib; {
    enable = mkEnableOption "Tools for Content Creation";
    impermanence = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable Impermanence support";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    rose.home.impermanence.extraDirectories = [
      ".local/share/krita"
      ".config/GIMP"
      ".config/libresprite"
      ".config/obs-studio"
    ];

    home.packages = with pkgs; [
      audacity
      inkscape
      upscayl
      halftone
      krita
      libresprite
      gimp
      czkawka
      lmms
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        input-overlay
        obs-pipewire-audio-capture
      ];
    };
  };
}
