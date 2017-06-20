#
# Cookbook:: bender_is_great
# Spec:: bender
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bender_is_great::bender' do
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |platform, version|
    version.each do |v|
      context "When creating the bender.html landing page on #{platform.capitalize} #{v}" do

        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            node.normal['bender_is_great']['user'] = user
            node.normal['bender_is_great']['group'] = group
          end.converge(described_recipe)
        end
        let(:user) { 'root' }
        let(:group) { 'root' }
        let(:template) { chef_run.template('/var/www/bender.html') }

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'deletes the index.html file' do
          expect(chef_run).to delete_file('/var/www/index.html')
        end

        it 'creates a landing page for Bender' do
          expect(chef_run).to create_template('/var/www/bender.html').with(
            user: user,
            group: group,
            mode: '0644'
          )
        end

        it 'logs the success of building the bender.html page' do
          expect(chef_run).to write_log('REMEMBER ME!').with(
            level: :info
          )
        end

      end
    end
  end
end
