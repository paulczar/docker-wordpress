# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "Use a newer version of Vagrant (1.2.1+)"
end


# Allows us to pick a different box by setting Environment Variables
BOX_NAME = ENV['BOX_NAME'] || "precise64"
BOX_URI = ENV['BOX_URI'] || "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

Vagrant.configure("2") do |config|
  # Cachier - speeds up subsequent runs.
  # vagrant plugin install vagrant-cachier
  config.cache.auto_detect = true
  #config.cache.enable_nfs  = true

  
  config.vm.define :wordpress do |config|
    config.vm.hostname = "wordpress"
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    config.vm.synced_folder "wordpress", "/var/www"
    config.vm.network :private_network, ip: "33.33.33.33"
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.ssh.forward_agent = true
    config.vm.provision :shell, :inline => <<-SCRIPT
      apt-get update
      DEBIAN_FRONTEND=noninteractive apt-get -y -q install apache2 mysql-server php5-mysql php5 libapache2-mod-php5
      service apache2 restart
      /usr/bin/mysqladmin create wordpress
      [[ -e /vagrant/wordpress.sql ]] && /usr/bin/mysql wordpress < /vagrant/wordpress.sql
      echo you may want to run the following :-
      #echo "sudo su -c 'echo \"33.33.33.33   wordpress\" >> /etc/hosts'"
      echo "sudo sed -i 's/^.*wordpress.*$/33.33.33.33 wordpress/' /etc/hosts"
    SCRIPT
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", 2]
      vb.customize ["modifyvm", :id, "--memory", 2048]
    end
  end
end
