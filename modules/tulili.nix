{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  myusername = "tulili";
in
{
  imports = [
    (import "${home-manager}/nixos")
    #./${myusername}/firefox.nix
  ]; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nixpkgs.config.allowUnfree = true;
  
  services.flatpak.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.users.${myusername} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "vboxusers" "libvirtd" ];
    shell = pkgs.fish;
  };
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  programs.steam.enable = true;

  environment.localBinInPath = true;
  
  home-manager.users.${myusername} = {
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    home.username = "${myusername}";
    home.homeDirectory = "/home/${myusername}";

    home.packages = with pkgs; [
      vscode
      nerdfonts
      yadm
      onedrive
      podman-compose
      docker-compose
      gnumake
      devbox
      lutris
      lazygit
      apx
      darcs
      unzip
      fish
      qbittorrent
      just
      git
      tmux
    ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
