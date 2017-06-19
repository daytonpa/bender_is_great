#
# Cookbook:: bender_is_great
# Recipe:: apache
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'apache2' do
  action :install
end

service 'apache2' do
  supports :status => true, :reload => true, :restart => true
  action [:enable, :start]
end

log "I'm back, baby!" do
  level :info
  message 'Successfully installed and started Apache'
end
