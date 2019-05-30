Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.define vm_name="server#{i}" do |server|
      server.vm.box = "achuchulev/nomad-server"
      server.vm.box_version = "0.0.1"
      server.vm.hostname = "server#{i}"
      server.vm.network "private_network", ip: "192.168.10.1#{i}"
      server.vm.synced_folder ".", "/vagrant", disabled: false
    end
  end

  (1..1).each do |i|
    config.vm.define vm_name="client#{i}" do |client|
      client.vm.box = "achuchulev/nomad-client"
      client.vm.box_version = "0.0.1"
      client.vm.hostname = "client#{i}"
      client.vm.network "private_network", ip: "192.168.10.2#{i}"
      client.vm.synced_folder ".", "/vagrant", disabled: false
    end
  end

  config.vm.define vm_name="frontend" do |frontend|
    frontend.vm.box = "achuchulev/nomad-frontend"
    frontend.vm.box_version = "0.0.1"
    frontend.vm.hostname = "frontend"
    frontend.vm.network "private_network", ip: "192.168.10.250"
    frontend.vm.synced_folder ".", "/vagrant", disabled: false
  end

  # Set memory & CPU for Virtualbox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
    vb.cpus = "1"
  end
end
