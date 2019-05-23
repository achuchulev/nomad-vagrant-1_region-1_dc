# Setup data dir
data_dir  = "/opt/nomad"

# Give the agent a unique name. Defaults to hostname
name = "client"

advertise {
  rpc = "{{ GetInterfaceIP \"eth0\" }}"
  http = "{{ GetInterfaceIP \"eth0\" }}"
  serf = "{{ GetInterfaceIP \"eth0\" }}"
}

# Enable the client
client {
  enabled = true

  options = {
    "driver.raw_exec" = "1"
    "driver.raw_exec.enable" = "1"
  }

}

# Require TLS
tls {
  http = true
  rpc  = true

  ca_file   = "/vagrant/ssl/ca/nomad-ca.pem"
  cert_file = "/home/vagrant/nomad/ssl/client.pem"
  key_file  = "/home/vagrant/nomad/ssl/client-key.pem"

  verify_server_hostname = true
  verify_https_client    = true
}
