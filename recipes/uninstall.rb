#
# Cookbook:: national_parks_cookbook
# Recipe:: uninstall
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Undo the install process to remove all artifacts of this application

###############################################################################
# Remove the application recipe artifacts first

package 'maven' do
  action :remove
end

src_path = '/home/tomcat/national_parks'
tmp_path = Chef::Config[:file_cache_path]

directory src_path do
  recursive true
  action :delete
end

directory '/opt/tomcat8.5/webapps/national-parks' do
  recursive true
  action :delete
end

file '/opt/tomcat8.5/webapps/national-parks.war' do
  action :delete
end

file "#{tmp_path}/check-nationalparks-data.sh" do
  action :delete
end

# Could implement an unload of the data collection from Mongo, but we're going to be lazy
# instead and just let the removal of Mongo from the system do the clean up.
# execute 'Load National Park Data' do
#   command './import-data.sh'
#   user 'tomcat'
#   group 'tomcat'
#   cwd src_path
#   action :run
#   not_if "#{tmp_path}/check-nationalparks-data.sh"
# end

###############################################################################
# Remove the tomcat recipe artifacts next

# Stop and disable tomcat service if requested
service 'tomcat8' do
  action [:disable, :stop]
end

user 'tomcat' do
  action :remove
end

group 'tomcat' do
  action :remove
end

# Delete tomcat archive
file "#{tmp_path}/#{node['tomcat8']['archive_name']}" do
  action :delete
end

# Remove tomcat install dir
directory node['tomcat8']['install_location'] do
  recursive true
  action :delete
end

# Remove the tomcat archive Extract
directory node['tomcat8']['install_location'] do
  recursive true
  action :delete
end

# Remove the service file
file '/etc/systemd/system/tomcat8.service' do
  action :delete
end

###############################################################################
# Remove the mongo recipe artifacts next

service 'mongodb' do
  action [:disable, :stop]
end

file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
  action :delete
end

%w(
  mongodb-org
  mongodb-org-server
  mongodb-org-mongos
  mongodb-org-tools
  mongodb-org-shell
).each do |pkg|
  package pkg do
    action :remove
  end
end

# Install the service file
file '/etc/systemd/system/mongodb.service' do
  action :delete
end

