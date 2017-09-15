require 'pp'

poise_service_user node['consul']['service_user'] do
    group node['consul']['service_group']
    shell node['consul']['service_shell'] unless node['consul']['service_shell'].nil?
end  

directory '/etc/consul.d/bootstrap' do
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    recursive true
    action :create
end

template '/etc/consul.d/bootstrap/config.json' do
    source 'bootstrap-config.json.erb'
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    variables({
        encrypt_key: node['consul']['encrypt_key'],
        data_dir: node['consul']['data_dir'],
        data_center: node['consul']['datacenter']
    })
end

directory '/etc/consul.d/server' do
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    recursive true
    action :create
end

join_servers =  search(:node, 'recipes:"consul_cluster"')
startup_type = join_servers.empty? ? 'bootstrap' : 'server'

template '/etc/consul.d/server/config.json' do
    source 'server-config.json.erb'
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    variables({
        encrypt_key: node['consul']['encrypt_key'],
        data_dir: node['consul']['data_dir'],
        data_center: node['consul']['datacenter'],
        join: join_servers.map { |n| n['ipaddress'] }
    })
end

directory '/etc/consul.d/client' do
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    recursive true
    action :create
end

directory node['consul']['data_dir'] do
    owner node['consul']['service_user']
    group node['consul']['service_group']
    mode '0755'
    recursive true
    action :create
end

package 'unzip'

ark "consul" do
    url  node['consul']['download_url']
    path "/usr/local/bin"
    creates "consul"
    owner node['consul']['service_user']
    group node['consul']['service_group']
    action :dump
  end

poise_service 'consul' do
    command "/usr/local/bin/consul agent -ui -config-dir /etc/consul.d/#{startup_type}"
    user node['consul']['service_user']
end