# Neovim Config

Neovim configuration that is managed stand-alone and not in the other [Nix configuration](https://github.com/jfkisafk/nix).
Even though _nixvim_ is present, adding to Nix meant every small update required reloading
the entire Nix/home-manager configuration.

This way we can lazy load the plugins and LSPs quickly while maintaining the same Neovim
development enbvironment.

## Installation

```shell
git@github.com:jfkisafk/nix.git ~/.config/nvim
```
