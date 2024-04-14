# Rose.nix

My all-in-one configuration for all my nix-y needs!
This contains my NixOS configuration, home-manager, neovim, and anything else I may seem fit!

You should be able to use my configurations by cloning this repository and running any command in the `Justfile`, those being `home-manager switch`, and `nix-rebuild` ones!

## Making a ISO file with some helpful tools

There is also a config file for an ISO that has some tools and drivers missing in the original minimal ISO. To make it, you can run
`task build-iso`, and the `result` folder should have your iso!
