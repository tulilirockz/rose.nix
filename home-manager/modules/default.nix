{ ... }: {
  imports = [
    ./tools
    ./services
    ./desktops
    ./browsers.nix
    ./impermanence.nix
  ];
}
