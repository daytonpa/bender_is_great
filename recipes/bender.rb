#
# Cookbook:: bender_is_great
# Recipe:: bender
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Out with the old
file '/var/www/index.html'do
  action :delete
end

# In with the new
template '/var/www/bender.html' do
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0644'
  source 'bender.html.erb'
end

log 'REMEMBER ME!' do
  level :info
  message 'You have successfully built bender.html'
end
