#
# Cookbook:: national_parks_cookbook
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Enables SSL and mod_jk

package 'httpd'
# package 'epel-release'
# package 'tomcat-native'
package 'mod_ssl'

days = node['national_parks']['cert']['days']
subject = node['national_parks']['cert']['subject']
key = node['national_parks']['cert']['key']
crt = node['national_parks']['cert']['crt']

execute 'Create proper SSL cert to match hostname' do
  command "openssl req -x509 -nodes -days #{days} -newkey rsa:2048 -subj #{subject} -keyout #{key} -out #{crt}"
  action :run
  not_if "test -f #{crt}"
end

# execute 'Create crt file for import into Workstation' do
#   command "cp -a #{crt} /home/ubuntu/#{node['hostname']}.automate-demo.com.crt"
#   action :run
#   not_if "test -f /home/ubuntu/#{node['hostname']}.automate-demo.com.crt"
# end

# execute 'a2enmod jk'
# execute 'a2enmod ssl'
# execute 'a2ensite default-ssl'

# Configure Apache

service 'httpd' do
  action :nothing
end

template '/etc/httpd/conf.d/ssl.conf' do
  action :create
  source 'ssl.conf.erb'
  notifies :restart, 'service[httpd]', :delayed
end

# template '/etc/httpd/conf.modules.d/01-ssl.conf' do
#   action :create
#   source '01-ssl.conf.erb'
#   notifies :restart, 'service[httpd]', :delayed
# end

# Configure Tomcat

service 'tomcat8' do
  action :nothing
end

# template '/etc/tomcat8/server.xml' do
#   action :create
#   source 'server.xml.erb'
#   notifies :restart, 'service[tomcat8]'
# end
