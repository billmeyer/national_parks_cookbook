#
# Cookbook:: national_parks_cookbook
# Recipe:: application
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'maven'

src_path = '/home/tomcat/national_parks'
tmp_path = Chef::Config[:file_cache_path]

git src_path do
  repository 'https://github.com/billmeyer/national-parks.git'
  revision 'v0.1.5'
  user 'tomcat'
  group 'tomcat'
  action :checkout
end

execute 'Build Application' do
  command 'mvn package'
  user 'tomcat'
  group 'tomcat'
  cwd src_path
  action :run
end

remote_file '/opt/tomcat8.5/webapps/national-parks.war' do
  source 'file:///home/tomcat/national_parks/target/national-parks.war'
  mode '0644'
end

template "#{tmp_path}/check-nationalparks-data.sh" do
  source 'check-nationalparks-data.sh.erb'
  owner 'tomcat'
  group 'tomcat'
  mode '0700'
  action :create
end

execute 'Load National Park Data' do
  command './import-data.sh'
  user 'tomcat'
  group 'tomcat'
  cwd src_path
  action :run
  not_if "#{tmp_path}/check-nationalparks-data.sh"
end
