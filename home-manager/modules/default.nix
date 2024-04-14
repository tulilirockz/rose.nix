{ ... }: {
  imports = [
    ./tools/cli.nix
    ./tools/dev.nix
    ./tools/creation.nix
    ./services
    ./desktops
    ./browsers.nix
    ./impermanence.nix
  ];
}
