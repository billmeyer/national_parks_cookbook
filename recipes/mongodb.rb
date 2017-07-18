#
# Cookbook:: national_parks_cookbook
# Recipe:: mongo
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  package 'mongodb'

when 'centos', 'rhel', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
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
else
  raise "Don't know how to install mongodb for the family #{node['platform_family']}"
end

service 'mongodb' do
  action [:enable, :start]
end
