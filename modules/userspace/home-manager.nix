{ config, pkgs, ... }:

{
  imports = [ ./home-manager/std-dconf.nix ];

  programs.home-manager.enable = true;
  home.username = "tulili";
  home.homeDirectory = "/home/tulili";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gnumake
    lazygit
    darcs
    unzip
    just
    git
    tmux
    ollama
    buildah
    gh
    incus
    wl-clipboard
    fd
    ripgrep
    nixos-generators
    podman-compose
    docker-compose
    fish
  ];

  home.file = {
    ".gitconfig".source = ./home-manager/gitconfig;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
