#
# Cookbook:: bender_is_great
# Spec:: nginx
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bender_is_great::apache' do
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |platform, version|
    version.each do |v|
      context "When installing and configuring Apache on #{platform.capitalize} #{v}" do

        let(:user) { 'root' }
        let(:group) { 'root' }

        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            node.normal['bender_is_great']['user'] = user
            node.normal['bender_is_great']['group'] = group
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'installs the apache2 package' do
          expect(chef_run).to install_package('apache2')
        end

        it 'starts and enables the Apache service' do
          expect(chef_run).to enable_service('apache2')
          expect(chef_run).to start_service('apache2')
        end

        it 'creates the apache2.conf, bender_is_great.conf, and ports.conf file from a template' do
          %w(apache2 bender_is_great ports).each do |filename|
            expect(chef_run).to create_template("/etc/apache2/#{filename}.conf").with(
              user: user,
              group: group,
              mode: '0755'
            )
          end
        end

        it 'Bender proclaims mortality as a waste' do
          expect(chef_run).to write_log('Anything less than immortality is a complete waste of time...').with(
            level: :info
          )
        end
      end
    end
  end
end
