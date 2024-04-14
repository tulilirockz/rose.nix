{ ... }: {
  imports = [
    ./plasma.nix
    ./gnome.nix
    ./niri.nix
    ./wayfire.nix
    ./sway.nix
    ./components
    ./wm.nix
  ];
}
