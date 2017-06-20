#
# Cookbook:: bender_is_great
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bender_is_great::apache' do
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |platform, version|
    version.each do |v|
      context "When installing apache on #{platform.capitalize} #{v}" do
        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            # Default attributes
          end.converge(described_recipe)
        end
        let(:service) { chef_run.service('apache2') }

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'installs apache 2 via package' do
          expect(chef_run).to install_package('apache2')
        end

        it 'starts and enables the apache2 service' do
          expect(chef_run).to start_service('apache2')
          expect(chef_run).to enable_service('apache2')
        end

        it 'Bender declares his present existence' do
          expect(chef_run).to write_log("I'm back, baby!")
        end

      end
    end
  end
end
