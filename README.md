# StarUnity's Dotfiles

My dotfiles on MacOS/ArchLinux

# Usage

```shell
git clone https://github.com/starunity/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Select the configuration file according to your needs
stow -t ~ zsh
```

## zsh dependencies

MacOS

```shell
brew install stow zoxide bat fd ripgrep eza
```

ArchLinux

```shell
sudo pacman -Sy stow zoxide bat fd ripgrep eza
```

Debian/Ubuntu

```shell
sudo apt install stow zoxide bat fd-find ripgrep eza
```