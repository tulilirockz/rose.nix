{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.rose.system.users;
in
{
  options.rose.system.users = with lib; {
    enable = mkEnableOption "Create default users";
    tulili = mkOption {
      default = { };
      description = "Enable Home-Manager and me!";
      type = lib.types.submodule (_: {
        options.enable = lib.mkEnableOption "Tulili user";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      localBinInPath = true;
      systemPackages = with pkgs; [
        (writeScriptBin "sudo" ''
          ${pkgs.systemd}/bin/systemd-run --uid=0 --gid=0 --same-dir -E TERM=$TERM -E PATH=$PATH --pty --quiet --pipe --collect $@
        '')
      ];
      defaultPackages = pkgs.lib.mkForce (
        with pkgs;
        [
          zstd
          xz
          gzip
          bzip2
          mkpasswd
          util-linux
          stdenv.cc.libc
          zsh
          util-linux
          netcat
          uutils-coreutils-noprefix
          curl
          config.programs.ssh.package
        ]
      );
    };
    security.sudo.enable = false;

    users = {
      defaultUserShell = pkgs.nushellFull;
      mutableUsers = false;
      users.root = {
        hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
      };
      users.tulili = lib.mkIf cfg.tulili.enable {
        group = "tulili";
        isNormalUser = true;
        hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
        extraGroups = [
          "wheel"
          "libvirtd"
          "qemu"
          "wireshark"
        ];
        useDefaultShell = true;
      };
      groups.tulili = {
        gid = 1000;
      };
    };

    services.flatpak.enable = true;

    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
      };
      useGlobalPkgs = true;
      users = {
        tulili = _: {
          imports = with inputs; [
            plasma-manager.homeManagerModules.plasma-manager
            persist-retro.nixosModules.home-manager.persist-retro
            impermanence.nixosModules.home-manager.impermanence
            ../../../home-manager/configurations/main-nixos.nix
          ];
        };
      };
    };
  };
}
