{
  config,
  pkgs,
  ...
}: let
  myusername = "tulili";
in {
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
    flake = "${config.users.users.${myusername}.home}/opt/tulili.nix";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
  };

  programs.firefox.enable = true;

  services.flatpak.enable = true;
  users.defaultUserShell = pkgs.nushell;
  users.users.${myusername} = {
    isNormalUser = true;
    extraGroups = ["wheel" "libvirtd" "incus-admin"];
    shell = pkgs.nushell;
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
    enable = false;
    useBabelfish = true;
  };

  environment.localBinInPath = true;

  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    gnome.gnome-boxes
    cage
    distrobox
    waydroid
    nerdfonts
    home-manager
  ];
}
