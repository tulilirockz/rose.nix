{
  config,
  pkgs,
  lib,
  inputs,
  preferences,
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
          ${pkgs.systemd}/bin/systemd-run --uid=0 --gid=0 -d -E TERM=$TERM -E PATH=$PATH -t -q -P -G $@
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
          bashInteractive
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
      defaultUserShell = pkgs.nushell;
      mutableUsers = false;
      users.${preferences.username} = lib.mkIf cfg.tulili.enable {
        group = "users";
        isNormalUser = true;
        initialHashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
        extraGroups = [
          "wheel"
          "libvirtd"
          "qemu"
        ];
        useDefaultShell = true;
      };
    };

    services.flatpak.enable = true;

    home-manager = {
      extraSpecialArgs = {
        inherit preferences;
        inherit inputs;
      };
      useGlobalPkgs = true;
      users = {
        tulili = _: {
          imports =
            with inputs;
            [
              plasma-manager.homeManagerModules.plasma-manager
              persist-retro.nixosModules.home-manager.persist-retro
              nix-colors.homeManagerModules.default
              impermanence.nixosModules.home-manager.impermanence
            ]
            ++ [ ../../../home-manager/configurations/main-nixos.nix ];
        };
      };
    };
  };
}
