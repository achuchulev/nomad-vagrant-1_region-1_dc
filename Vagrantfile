
SERVER_COUNT = 3
CLIENT_COUNT = 1

$script = <<-SCRIPT
# get host private IP
IP=$(hostname -I | cut -f2 -d' ')

# adjust IP to bind
[ -d /etc/nomad.d/ ] && {
  sed -i "s/0.0.0.0/${IP}/g" /etc/nomad.d/*.hcl
}

echo 'datacenter = "dc1"' >> /etc/nomad.d/*.hcl
echo 'region = "global"' >> /etc/nomad.d/*.hcl

# Restart Nomad service
systemctl restart nomad.service
SCRIPT

Vagrant.configure("2") do |config|
  (1..(SERVER_COUNT)).each do |i|
    config.vm.define vm_name="server#{i}" do |server|
      server.vm.box = "achuchulev/nomad-server"
      server.vm.box_version = "0.0.1"
      server.vm.hostname = "server#{i}"
      server.vm.network "private_network", ip: "192.168.10.1#{i}"
      server.vm.synced_folder ".", "/vagrant", disabled: false
      server.vm.provision "shell", inline: $script, privileged: "true"
    end
  end

  (1..(CLIENT_COUNT)).each do |i|
    config.vm.define vm_name="client#{i}" do |client|
      client.vm.box = "achuchulev/nomad-client"
      client.vm.box_version = "0.0.1"
      client.vm.hostname = "client#{i}"
      client.vm.network "private_network", ip: "192.168.10.2#{i}"
      client.vm.synced_folder ".", "/vagrant", disabled: false
      client.vm.provision "shell", inline: $script, privileged: "true"
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
