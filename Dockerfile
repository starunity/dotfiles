FROM docker/dev-environments-default:stable-1

WORKDIR /root

RUN /bin/sh -c 'apt-get update \
    && apt-get -y install zsh stow unzip zoxide bat fd-find ripgrep exa'

RUN /bin/sh -c 'git clone https://ghproxy.com/https://github.com/starunity/dotfiles.git'

RUN /bin/sh -c 'rm /root/.zshrc \
    && stow -t /root -d /root/dotfiles zsh'

RUN chsh -s /usr/bin/zsh
