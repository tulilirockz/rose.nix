# tulili.nix

This is my NixOS configuration and everything needed to actually make it work.
There are some scripts and helpful things in the Makefile!

Use either make or the raw command for switching to this configuration (just make sure you have `/etc/nixos/hardware-config.nix`)
```sh
nixos-rebuild --use-remote-sudo --impure switch --flake github:tulilirockz/tulili.nix#machine-here
```

## Installation from Minimal Disk

Generate your config for the hardware-config.nix file in `/etc/nixos`
```sh 
nixos-generate-config --root /mnt
```

Then install your system straight from the github flake
```sh
git clone github.com/tulilirockz/tulili.nix /mnt/etc/nixos
nixos-install --flake /mnt/etc/nixos#machine-here
```
