#
# Cookbook:: national_parks_cookbook
# Recipe:: application
#
# Copyright:: 2017, The Authors, All Rights Reserved.

return unless platform?('windows')

# tmp_path = Chef::Config[:file_cache_path]

chocolatey_package 'maven'
src_path = 'c:\Users\vagrant\national_parks'

git src_path do
  repository 'https://github.com/billmeyer/national-parks.git'
  revision 'v0.1.5'
  action :checkout
end

execute 'Build Application' do
  command 'mvn package'
  cwd src_path
  action :run
end

remote_file 'C:\Program Files\Apache Software Foundation\tomcat\apache-tomcat-8.5.12\webapps\national-parks.war' do
  source 'file:///c:\Users\vagrant\national_parks\target\national-parks.war'
end

# template "#{tmp_path}/check-nationalparks-data.sh" do
#   source 'check-nationalparks-data.sh.erb'
#   owner 'tomcat'
#   group 'tomcat'
#   mode '0700'
#   action :create
# end

execute 'Load National Park Data' do
  cwd 'C:\Program Files\MongoDB\Server\3.4\bin'
  command "mongoimport --drop -d demo -c nationalparks --type json --jsonArray --file #{src_path}/national-parks.json"
  action :run
  returns 1
  live_stream true
  #   not_if "#{tmp_path}/check-nationalparks-data.sh"
end
