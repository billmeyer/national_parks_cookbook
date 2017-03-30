#
# Cookbook:: national_parks
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'national_parks::tomcat' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect(chef_run).to create_user('tomcat')
      expect(chef_run).to create_group('tomcat')
      expect { chef_run }.to_not raise_error
    end
  end
end
