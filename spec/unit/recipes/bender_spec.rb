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
      context "When remembering how great Bender is on #{platform.capitalize} #{v}" do

        let(:user) { 'root' }
        let(:group) { 'root' }
        let(:comp_message) { 'Test this jazz!' }

        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            node.normal['bender_is_great']['user'] = user
            node.normal['bender_is_great']['group'] = group
            node.normal['bender_is_great']['completion_message'] = comp_message
          end.converge(described_recipe, 'bender_is_great::apache')
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'creates a new server directory for Bender' do
          expect(chef_run).to create_directory('/var/www/html/bender_is_great').with(
            user: user,
            group: group,
            mode: '0755'
          )
        end

        it 'creates a landing index.html page for Bender' do
          expect(chef_run).to create_template('/var/www/html/bender_is_great/index.html').with(
            user: user,
            group: group,
            mode: '0755',
            source: 'bender.html.erb'
          )
        end

        it 'logs the success of building the bender.html page' do
          expect(chef_run).to write_log(comp_message).with(
            level: :info
          )
        end
      end
    end
  end
end
