{...}: {
  imports = [
    ./shared.nix
    ./wm.nix
  ];

  programs.river.enable = true;

  xdg.portal.wlr.enable = true;
}
