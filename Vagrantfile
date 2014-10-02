# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = "example.com"
boxes = [
	{ :name => 'os-nova-01', :public_ip => '172.16.0.201', :private_ip => '192.168.0.201', :cpus => 1, :memory => 512 },
#	{ :name => 'openstack-nova-02', :public_ip => '172.16.0.202', :private_ip => '192.168.0.202', :cpus => 2, :memory => 512 },
	{ :name => 'os-ctrl-01', :public_ip => '172.16.0.200', :private_ip => '192.168.0.200', :cpus => 1, :memory => 1024, :shell => 'controller.sh' },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

#  config.vbguest.auto_update = true

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.box = "ntbc-oel65"
      config.vm.hostname = "#{opts[:name]}.#{domain}"
      config.vm.network :public_network, ip: opts[:public_ip] if opts[:public_ip]
      config.vm.network :private_network, ip: opts[:private_ip] if opts[:private_ip]
      config.vm.provider "virtualbox" do |vb|
        vb.name = opts[:name]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--memory", opts[:memory]] if opts[:memory]
        vb.customize ["modifyvm", :id, "--cpus", opts[:cpus]] if opts[:cpus]
      end
      config.vm.provision :shell, :path => 'base.sh'
      config.vm.provision :shell, :path => opts[:shell] if opts[:shell]
    end
  end
end
