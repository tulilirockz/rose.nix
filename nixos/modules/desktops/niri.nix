{...}:{
  imports = [
    ./wm.nix
    ./shared.nix
  ];
  nix.settings.substituters = [ "https://niri.cachix.org" ];
  nix.settings.trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  programs.niri.enable = true;
}

