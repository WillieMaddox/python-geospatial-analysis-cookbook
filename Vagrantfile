# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "US/Central"
  end

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "PyGisCkBk"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 5432, host: 5432, auto_correct: true

  #config.vm.network :private_network, ip: "192.168.33.10"
  #config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
  end


#  config.vm.provision :shell, :privileged => false, :path => "installer_old.sh"
#  config.vm.provision :shell, :privileged => true, :path => "installer.sh"
  config.vm.provision :shell, :privileged => true, :path => "ch03/setup.sh"
  config.vm.provision :shell, :privileged => true, :path => "ch11/setup.sh"

end
