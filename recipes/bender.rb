#
# Cookbook:: bender_is_great
# Recipe:: bender
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory node['bender_is_great']['doc_root'] + '/' + \
          node['bender_is_great']['server_alias'] do
            
  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
end

# Create our bender index.html landing page
template node['bender_is_great']['doc_root'] + '/' + \
         node['bender_is_great']['server_alias'] + '/' + \
         node['bender_is_great']['main_page'] do

  owner node['bender_is_great']['user']
  group node['bender_is_great']['group']
  mode '0755'
  source 'bender.html.erb'
  notifies :restart, 'service[apache2]', :delayed
end

# Update our apache2.conf to view the landing page
# template '/etc/apache2/apache2.conf' do
#   owner node['bender_is_great']['user']
#   group node['bender_is_great']['group']
#   mode '0644'
#   source 'apache2.conf'
#   notifies :restart, 'service[apache2]', :delayed
# end

log node['bender_is_great']['completion_message'] do
  level :info
  message 'You have successfully built bender.html'
end
