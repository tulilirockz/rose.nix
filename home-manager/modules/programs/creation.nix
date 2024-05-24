{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.programs.creation;
in
{
  options.rose.programs.creation = with lib; {
    enable = mkEnableOption "Tools for Content Creation";
    impermanence = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable Impermanence support";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    rose.home.impermanence.extraDirectories = lib.mkIf cfg.impermanence.enable [
      ".local/share/krita"
      ".config/GIMP"
      ".config/libresprite"
      ".config/obs-studio"
      ".config/easyeffects"
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
      blockbench
      video-trimmer
    ];

    services.easyeffects.enable = true;

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
