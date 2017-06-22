#
# Cookbook:: bender_is_great
# Recipe:: bender
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Create our new server directory for Apache
directory node['bender_is_great']['doc_root'] + '/' + \
          node['bender_is_great']['server_alias'] do

  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
end

# Create our bender.html landing page inside our server directory
template node['bender_is_great']['doc_root'] + '/' + \
         node['bender_is_great']['server_alias'] + '/index.html' do

  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
  source 'index.html.erb'
  notifies :restart, 'service[apache2]', :delayed
end

log node['bender_is_great']['completion_message'] do
  level :info
  message 'You have successfully built bender.html'
end
