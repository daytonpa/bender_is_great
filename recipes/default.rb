#
# Cookbook:: bender_is_great
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Bite my shiny metal ass!

# Create a primary group
group node['bender_is_great']['group']

# Create sudo user for the instance
user node['bender_is_great']['user'] do
  group node['bender_is_great']['group']
  system node['bender_is_great']['system_user']
end

# Update our caches, depending on OS
case node['platform']
when 'ubuntu'
  include_recipe 'apt'
when 'centos'
  include_recipe 'yum'
else
  log 'This is the worst kind of discrimination there is: the kind against me!' do
    message <<-EOD
    The platform #{node['platform']} isn't supported.  Please choose between
    centos or ubuntu.
    EOD
    level :warn
  end
end

%w(apache bender).each do |recipe|
  include_recipe "bender_is_great::#{recipe}"
end
