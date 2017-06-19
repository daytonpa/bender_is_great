#
# Cookbook:: bender_is_great
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bender_is_great::default' do
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |platform, version|
    version.each do |v|
      context "When all attributes are default, on an #{platform.capitalize} #{v}" do
        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
            # Default attributes
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case platform
        when 'ubuntu'
          it 'includes the `apt` default recipe' do
            expect(chef_run).to include_recipe('apt::default')
          end
        when 'centos'
          it 'includes the `yum` default recipe' do
            expect(chef_run).to include_recipe('yum::default')
          end
        end

        it 'includes the `apache`, `nginx`, `bender` recipes' do
          %w(apache nginx bender).each do |recipe|
            expect(chef_run).to include_recipe("bender_is_great::#{recipe}")
          end
        end

        it 'does not piss Bender off!' do
          expect(chef_run).to_not write_log('This is the worst kind of discrimination there is: the kind against me!').with(
           level: :info
          )
        end

      end
    end
  end
end