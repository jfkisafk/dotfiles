# $HOME/.config dotfiles

> [!IMPORTANT]
> This package uses [stow](https://www.gnu.org/software/stow/) to manage the dotfiles in ~/.config.

## Why?

### Neovim configuration

Neovim configuration that is managed stand-alone and not in the other [Nix configuration](https://github.com/jfkisafk/nix).
Even though _nixvim_ is present, adding to Nix meant every small update required reloading
the entire Nix/home-manager configuration.

This way we can lazy load the plugins and LSPs quickly while maintaining the same Neovim
development enbvironment.

### Ghostty configuration

The [Ghostty](https://ghostty.org) configuration is managed in the same way, becuase nix does not provide a way to manage the ghostty configuration.

### Karabiner configuration

The [Karabiner](https://karabiner-elements.pqrs.org) configuration is managed in the same way, becuase nix does not provide a way to manage the karabiner configuration.

## Requirements

Make sure you have `stow` installed.

```shell
brew install stow
```

## Installation

Checkout the repository in your preferred dotfiles directory.

```shell
gh repo clone jfkisafk/dotfiles ~/.config/dotfiles
```

Just call stow from the repository root.

```shell
stow .
```
