#
# Cookbook:: national_parks_cookbook
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Enables SSL and mod_jk

days = node['national_parks']['cert']['days']
subject = node['national_parks']['cert']['subject']
key = node['national_parks']['cert']['key']
crt = node['national_parks']['cert']['crt']
csr = node['national_parks']['cert']['csr']

# execute 'Create proper SSL cert to match hostname' do
#   command "openssl req -x509 -nodes -days #{days} -newkey rsa:2048 -subj #{subject} -keyout #{key} -out #{crt}"
#   action :run
#   not_if "test -f #{crt}"
# end

bash 'Create proper SSL cert to match hostname' do
  cwd '/tmp'
  code <<-EOH
    openssl genrsa -des3 -passout pass:x -out #{key}.pass 2048
    openssl rsa -passin pass:x -in #{key}.pass -out #{key}
    rm #{key}.pass
    openssl req -new -key #{key} -out #{csr} -subj #{subject}
    openssl x509 -req -days #{days} -in #{csr} -signkey #{key} -out #{crt}
  EOH
end

# Install Apache HTTPd

case node['platform_family']
when 'debian', 'ubuntu'
  package 'apache2'
when 'centos', 'rhel', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
  package 'httpd'
  package 'mod_ssl'
else
  raise "Don't know which Apache HTTPd package to install for the family #{node['platform_family']}"
end

# Configure Apache

###################
## Debian
case node['platform_family']
when 'debian', 'ubuntu'
  execute 'a2enmod ssl' do
    notifies :restart, 'service[apache2]', :delayed
  end

  execute 'a2enmod proxy' do
    notifies :restart, 'service[apache2]', :delayed
  end

  execute 'a2enmod proxy_http' do
    notifies :restart, 'service[apache2]', :delayed
  end

  execute 'a2ensite default-ssl' do
    notifies :restart, 'service[apache2]', :delayed
  end

  service 'apache2' do
    action [:enable, :start]
  end

  template '/etc/apache2/sites-available/default-ssl.conf' do
    action :create
    source 'ssl.conf.erb'
    notifies :restart, 'service[apache2]', :delayed
  end

###################
## RPM
when 'centos', 'rhel', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
  service 'httpd' do
    action [:enable, :start]
  end

  template '/etc/httpd/conf.d/ssl.conf' do
    action :create
    source 'ssl.conf.erb'
    notifies :restart, 'service[httpd]', :delayed
  end

else
  raise "Don't know which Apache HTTPd package to install for the family #{node['platform_family']}"
end

# Configure Tomcat

service 'tomcat8' do
  action :nothing
end

# template '/etc/tomcat8/server.xml' do
#   action :create
#   source 'server.xml.erb'
#   notifies :restart, 'service[tomcat8]'
# end
