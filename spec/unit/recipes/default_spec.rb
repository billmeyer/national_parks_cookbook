#
# Cookbook:: national_parks_cookbook
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'national_parks_cookbook::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new # (platform: 'centos', version: '7.2.1511')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      # stub_command('test -f /etc/pki/tls/certs/Fauxhai.automate-demo.com.crt').and_return(0)
      stub_command('/tmp/check-nationalparks-data.sh').and_return(0)
      expect { chef_run }.to_not raise_error
    end
  end
end
