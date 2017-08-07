#
# Cookbook:: national_parks_cookbook
# Recipe:: mongo
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']

#####################################################################
# Debian Install
when 'debian', 'ubuntu'

  package 'mongodb'

#####################################################################
# RPM Install
when 'centos', 'rhel', 'redhat', 'fedora', 'amazon'

  cookbook_file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
    source 'mongodb-org-3.4.repo'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  package 'mongodb-org'

  # Install the service file
  template '/etc/systemd/system/mongodb.service' do
    source 'mongodb.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  service 'mongodb' do
    action [:enable, :start]
  end

#####################################################################
# Windows Install
when 'windows'

  chocolatey_package 'mongodb'

  directory 'c:\\data\\db' do
    recursive true
  end

  directory 'c:\\data\\log' do
    recursive true
  end

  template 'C:\\Program Files\\MongoDB\\Server\\3.4\\mongod.cfg' do
    source 'mongod.cfg.erb'
  end

  execute 'Install MongoDB Service' do
    cwd 'C:\Program Files\MongoDB\Server\3.4\bin'
    command 'mongod.exe --config "C:\Program Files\MongoDB\Server\3.4\mongod.cfg" --install'
    returns 20
    # ignore_failure true
  end

  windows_service 'mongodb' do
    action [:enable, :start]
  end

else
  raise "Don't know how to install mongodb for the family #{node['platform_family']}"
end
