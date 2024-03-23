{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.creation;
in
{
  options = {
    programs.creation.enable = lib.mkEnableOption "Content creation tweaks";
  };
  config = lib.mkIf cfg.enable {
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
