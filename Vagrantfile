# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "US/Central"
  end

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "PyGisCkBk"
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
  end

  #config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.provision :shell, :privileged => false, :path => "installer.sh"

end
