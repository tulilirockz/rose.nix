{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.rose.system.nixos;
in
{
  options.rose.system.nixos = with lib; {
    enable = mkEnableOption "Enable NixOS specific settings";

    autoUpgrade = mkOption {
      default = { };
      description = "Automatic updates preconfigured to this flake by default";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable AutoUpdate";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = lib.mkIf cfg.autoUpgrade.enable {
      enable = true;
      dates = "12:00";
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L"
      ];
      randomizedDelaySec = "45min";
    };

    nix = {
      gc = {
        automatic = true;
        persistent = true;
        dates = "daily";
        options = "--delete-older-than 2d";
      };
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        use-xdg-base-directories = true;
        auto-optimise-store = true;
        allowed-users = [ "@wheel" ];
      };
      channel.enable = false;
    };
  };
}
