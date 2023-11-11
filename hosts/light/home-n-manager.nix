{ pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];
  
  users.defaultUserShell = pkgs.fish;
  users.users.tulili = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
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

  environment.localBinInPath = true;
  
  home-manager.users.tulili = {
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    home.username = "tulili";
    home.homeDirectory = "/home/tulili";

    home.packages = with pkgs; [
      vscode
      nerdfonts
      yadm
      onedrive
      podman-compose
      docker-compose
      gnumake
      devbox
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}