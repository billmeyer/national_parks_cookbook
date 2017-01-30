#
# Cookbook:: national_parks
# Recipe:: mongo
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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
