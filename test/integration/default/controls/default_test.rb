describe file('/etc/consul.d/server') do
    it { should be_directory }
end

describe file('/etc/consul.d/client') do
    it { should be_directory }
end

describe file('/etc/consul.d/bootstrap') do
    it { should be_directory }
end

