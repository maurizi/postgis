# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.3"

Vagrant.configure("2") do |config|
  # Settings for every machine

  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  # Global VirtualBox specific configurations
  config.vm.provider :virtualbox do |vb|
    # How much memory to use?
    vb.customize ["modifyvm", :id, "--memory", 2048]

    # How many CPUs to use?
    vb.customize ["modifyvm", :id, "--cpus", 1]

    # Prevent clock skew between guest and host OSes
    vb.customize ["guestproperty", "set", :id,
                  "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 100]
    vb.customize ["guestproperty", "set", :id,
                  "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start"]
    vb.customize ["guestproperty", "set", :id,
                  "/VirtualBox/GuestAdd/VBoxService/--timesync-interval", 1000]
  end

  # Multi-machine settings below
  config.vm.define "ubuntu-trusty" do |trusty|
    trusty.vm.box = "ubuntu/trusty64"
    # vm.box_url is required on older versions of Vagrant that do not support Vagrant cloud
    trusty.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/14.04/providers/virtualbox.box"
    trusty.vm.hostname = "postgis-ubuntu-trusty"
    trusty.vm.network :forwarded_port, guest: 5432, host: 15432

    trusty.vm.provision :shell, :path => "scripts/ubuntu-trusty.sh", privileged: false
  end
end
