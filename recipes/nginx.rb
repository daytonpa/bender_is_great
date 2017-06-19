#
# Cookbook:: bender_is_great
# Recipe:: nginx
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

service 'nginx' do
  supports :restart => true, :reload => true, :status => true
  action [:start, :enable]
end

template '/etc/nginx/nginx.conf' do
  user 'root'
  group 'root'
  mode '0644'
  source 'nginx.conf.erb'
  action :create
  notifies :restart, 'service[nginx]', :immediately
end

log 'Anything less than immortality is a complete waste of time...' do
  level :info
  message 'Successfully installed, configured, and started nginx'
end
