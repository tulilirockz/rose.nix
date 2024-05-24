{ config, lib, ... }:
let
  cfg = config.rose.home.general;
in
{
  options.rose.home.general.enable = lib.mkEnableOption "General home-manager options";

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;
    home = rec {
      username = "tulili";
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";

      sessionVariables = rec {
        GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
        NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
        TLDR_CACHE_DIR = "${XDG_CACHE_HOME}/tldr";
        CARGO_HOME = "${XDG_CACHE_HOME}/cargo";
        DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
        HISTFILE = "${XDG_STATE_HOME}/bash/history";
        XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
        MOZ_ENABLE_WAYLAND = "1";
      };
    };
  };
}
