# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.provider :libvirt do |libvirt|
#    libvirt.host = "docker-sandbox.com"
    libvirt.cpus = 2
    libvirt.memory = 2048
  end
end

