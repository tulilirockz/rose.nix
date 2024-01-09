{pkgs, ...}: {
  imports = [
    ./home-manager/dconf-theme.nix
    ./home-manager/managed-neovim.nix
  ];

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
    glab
    wl-clipboard
    fd
    ripgrep
    nixos-generators
    podman-compose
    docker-compose
    fish
    tldr
    manix
  ];

  programs.fish.enable = true;

  home.file = {
    ".gitconfig".source = ./home-manager/dotfiles/gitconfig;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.dconf-theme.enable = true;
  programs.dconf-theme.theme = "mine";

  programs.managed-neovim.enable = true;

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "daily";
  };
  services.flatpak.packages = [
    "com.obsproject.Studio"
    "com.bitwarden.desktop"
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "com.rafaelmardojai.Blanket"
    "io.github.flattool.Warehouse"
    "io.podman_desktop.PodmanDesktop"
    "net.lutris.Lutris"
    "org.audacityteam.Audacity"
    "org.chromium.Chromium"
    "org.gnome.Epiphany"
    "org.gnome.Firmware"
    "org.godotengine.Godot"
    "org.inkscape.Inkscape"
    "org.kde.krita"
    "org.onlyoffice.desktopeditors"
  ];
}
