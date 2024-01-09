# tulili.nix

My all-in-one configuration for all my nix-y needs!
This contains my NixOS configuration, home-manager, neovim, and anything else I may seem fit!

You should be able to use my configurations by just cloning this repository and running any command in the `Makefile`, those being `home-manager switch`, and `nix-rebuild` ones!

## Making a ISO file with some helpful tools

There is also a config file for an ISO that has some tools and drivers missing in the original minimal ISO. To make it, you can run
`make build-iso`, and the `result` folder should have your iso!

## Neovim configuration

There is also an neovim made with [nixvim](https://github.com/nix-community/nixvim) config integrated in this repo, you can run it by running:

```shell
nix run github:tulilirockz/tulili.nix#neovim
```
