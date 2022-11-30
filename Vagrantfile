# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian11"

  config.vm.provision "shell", inline: <<-SHELL
    # in China
    # sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    # sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
    
    apt-get update
    apt-get -y install zsh stow unzip

    runuser -l vagrant -c 'git clone https://github.com/starunity/dotfiles'
    runuser -l vagrant -c 'cp -rT ~/dotfiles/zsh/ ~'

    chsh -s /bin/zsh vagrant
  SHELL
end
