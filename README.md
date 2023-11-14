# tulili.nix

This is my NixOS configuration and everything needed to actually make it work.
There are some scripts and helpful things in the Makefile!

## Installation from Minimal Disk

This assumes that you have already setup your disks and everything, only continue after doing that!

1. Generate your config for the hardware-config.nix file in `/etc/nixos`
```sh 
nixos-generate-config --root /mnt
```

2. Then install your system straight from the github flake, making sure to have a `hardware-config.nix` file in it
```sh
nix-shell -p git
git clone github.com/tulilirockz/tulili.nix
cp /mnt/etc/nixos/hardware-config.nix tulili.nix/$(hostname)/
nixos-install --flake ./tulili.nix/nixos#machine-here
```

## Making a ISO file with some helpful tools

There is also a config file for an ISO that has some tools and drivers missing in the original minimal ISO. To make it, you can run
`make build-iso`, and the `result` folder should have your iso!
