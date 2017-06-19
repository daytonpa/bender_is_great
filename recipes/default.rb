#
# Cookbook:: bender_is_great
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Bite my shiny metal ass!

# Let us begin by updating our repo cache
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

include_recipe 'bender_is_great::apache'
include_recipe 'bender_is_great::nginx'
include_recipe 'bender_is_great::bender'
