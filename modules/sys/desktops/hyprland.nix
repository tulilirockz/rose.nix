{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./shared.nix
    ./wm.nix
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
  ];
}
