control 'nomad-package' do
  describe package('nomad') do
    it { should be_installed }
  end
end

control 'nomad-service' do
  describe service('nomad') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'nomad-config' do
  describe file('/etc/nomad/*.hcl') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '420' }
  end
end

control 'nomad-port-listening' do
  describe port(4646) do
    it { should be_listening }
    its('processes') {should include 'nomad'}
    its('protocols') { should include('tcp') }
    its('protocols') { should_not include('udp') }
  end
end

