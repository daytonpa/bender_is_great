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

#   We could type a similar resource over and over, but the redundancy is never
# ideal.  As illustrated above and below, this all gets pretty repetitive.
# Overall, it's bad code.  Instead, we can place our resouces inside a loop with
# as a stenciled resource.  There are only two things changing, so let's make
# use of that.
#
# Create bender_is_great.conf
# template '/etc/apache2/bender_is_great.conf' do
#   owner node['bender_is_great']['user']
#   group node['bender_is_great']['group']
#   mode '0755'
#   source 'bender_is_great.conf.erb'
#   notifies :restart, 'service[apache2]', :delayed
# end
#
# Open some ports
# template '/etc/apache2/ports.conf' do
#   owner node['bender_is_great']['user']
#   group node['bender_is_great']['group']
#   mode '0755'
#   source 'ports.conf.erb'
#   notifies :restart, 'service[apache2]', :delayed
# end
#
# Update our apache2.conf to view the landing page
# template '/etc/apache2/apache2.conf' do
#   owner node['bender_is_great']['user']
#   group node['bender_is_great']['group']
#   mode '0755'
#   source 'apache2.conf.erb'
#   notifies :restart, 'service[apache2]', :delayed
# end

%w(bender_is_great ports apache2).each do |filename|
  template "/etc/apache2/#{filename}.conf" do
    owner node['bender_is_great']['user']
    group node['bender_is_great']['group']
    mode '0755'
    source filename+'.conf.erb'

    #   We could have apache2 restart immediately after any change to any file,
    # but that will add up convergence time.  By setting the notification to
    # :delayed we are appending a service restart at the very end of the
    # converge.  Also, if chef-client notices the same resource being appended
    # to the end of the resource collection repetitively, it will only do it
    # once.  That's pretty neat.
    notifies :restart, 'service[apache2]', :delayed
  end
end

log 'Anything less than immortality is a complete waste of time...' do
  level :info
  message 'Successfully installed, configured, and started Apache'
end
