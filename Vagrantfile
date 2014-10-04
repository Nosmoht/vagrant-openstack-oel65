# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = "example.com"
boxes = [
	{ :name => 'os-nova-01', :public_ip => '172.16.0.201', :private_ip => '192.168.0.201', :cpus => 2, :memory => 4096 },
	{ :name => 'os-nova-02', :public_ip => '172.16.0.202', :private_ip => '192.168.0.202', :cpus => 2, :memory => 4096 },
	{ :name => 'os-ctrl-01', :public_ip => '172.16.0.200', :private_ip => '192.168.0.200', :cpus => 1, :memory => 2048, :shell => 'controller.sh' },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

#  config.vbguest.auto_update = true

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.box = "ntbc-oel65"
      # Following doesn't work so use: vagrant box add ntbc-oel65 https://www.dropbox.com/l/aWt8kMbMXJqdGFNEXPncXo
      #config.vm.box_url = "https://www.dropbox.com/l/aWt8kMbMXJqdGFNEXPncXo"
      config.vm.hostname = "#{opts[:name]}.#{domain}"
      config.vm.network :public_network, ip: opts[:public_ip], :bridge => "eno1" if opts[:public_ip]
      config.vm.network :private_network, ip: opts[:private_ip] if opts[:private_ip]
      config.vm.provider "virtualbox" do |vb|
        vb.name = opts[:name]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--memory", opts[:memory]] if opts[:memory]
        vb.customize ["modifyvm", :id, "--cpus", opts[:cpus]] if opts[:cpus]
      end
      config.vm.synced_folder "root/.ssh", "/root/.ssh", owner: "root", group: "root"
      config.vm.provision :shell, :path => 'base.sh'
      config.vm.provision :shell, :path => opts[:shell] if opts[:shell]
    end
  end
end
