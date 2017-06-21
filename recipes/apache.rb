#
# Cookbook:: bender_is_great
# Recipe:: nginx
#
# Copyright:: 2017, The Authors, All Rights Reserved.


%w(apache2).each do |pkg|
  package pkg do
    action :install
  end
end

service 'apache2' do
  supports :restart => true, :reload => true, :status => true
  action [:start, :enable]
end

# Verify the /var/www/ and /var/www/html directory permissions
directory '/var/www' do
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0777'
end
directory '/var/www/html' do
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0777'
end

# Modify our ports.conf and create the bender.html
template '/etc/apache2/bender_is_great.conf' do
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
  source 'bender_is_great.conf.erb'
  notifies :restart, 'service[apache2]', :delayed
end

template '/etc/apache2/ports.conf' do
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
  source 'ports.conf.erb'
  notifies :restart, 'service[apache2]', :delayed
end


log 'Anything less than immortality is a complete waste of time...' do
  level :info
  message 'Successfully installed, configured, and started Apache'
end
