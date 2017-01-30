#
# Cookbook:: national_parks
# Recipe:: tomcat
#
# Copyright:: 2017, The Authors, All Rights Reserved.

tmp_path = Chef::Config[:file_cache_path]

group 'tomcat' do
  gid '5001'
  action :create
end

user 'tomcat' do
  comment 'Unix Account for running Tomcat'
  uid '5001'
  gid 'tomcat'
  home '/home/tomcat'
  shell '/bin/bash'
  password 'password'
  manage_home true
  action :create
end

# Download tomcat archive
remote_file "#{tmp_path}/#{node['tomcat8']['archive_name']}" do
  source node['tomcat8']['download_url']
  owner node['tomcat8']['tomcat_user']
  mode '0644'
  action :create
end

# create tomcat install dir
directory node['tomcat8']['install_location'] do
  owner node['tomcat8']['tomcat_user']
  recursive true
  mode '0755'
  action :create
end

# extract the tomcat archive to the install location
bash 'Extract tomcat archive' do
  user node['tomcat8']['tomcat_user']
  cwd node['tomcat8']['install_location']
  code <<-EOH
    tar -zxvf #{tmp_path}/#{node['tomcat8']['archive_name']} --strip 1
  EOH
  action :run
end

# Install server.xml from template
# template "#{node['tomcat8']['install_location']}/conf/server.xml" do
#   source 'server.xml.erb'
#   owner node['tomcat8']['tomcat_user']
#   mode '0644'
# end

# # Install init script
# template '/etc/init.d/tomcat8' do
#   source 'tomcat8.erb'
#   owner 'root'
#   mode '0755'
# end

# Install the service file
template '/etc/systemd/system/tomcat8.service' do
  source 'tomcat8.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Start and enable tomcat service if requested
service 'tomcat8' do
  action [:enable, :start]
#   only_if { node['tomcat8']['autostart'] }
end
