#
# Cookbook:: bender_is_great
# Spec:: nginx
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bender_is_great::nginx' do
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |platform, version|
    version.each do |v|
      context "When installing and configuring nginx on #{platform.capitalize} #{v}" do

        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            # Default attributes
          end.converge(described_recipe)
        end

        let(:template) { chef_run.template('/etc/nginx/nginx.conf') }

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'installs nginx via package' do
          expect(chef_run).to install_package('nginx')
        end

        it 'starts and enables the nginx service' do
          expect(chef_run).to enable_service('nginx')
          expect(chef_run).to start_service('nginx')
        end

        it 'creates the nginx.conf file from a template' do
          expect(chef_run).to create_template('/etc/nginx/nginx.conf').with(
            user: 'root',
            group: 'root',
            mode: '0644'
          )
          expect(template).to notify('service[nginx]').to(:restart).immediately
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
