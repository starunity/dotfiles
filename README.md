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
brew install zoxide bat fd ripgrep exa
```

ArchLinux

```shell
sudo pacman -Sy zoxide bat fd ripgrep exa
```

Debian/Ubuntu

```shell
sudo apt install zoxide bat fd-find ripgrep exa
```