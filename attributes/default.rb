# default['tomcat8']['archive_name'] = 'apache-tomcat-8.5.11.tar.gz'
# default['tomcat8']['download_url'] = "http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.11/bin/#{default['tomcat8']['archive_name']}"
# default['tomcat8']['install_location'] = '/opt/tomcat8.5'
# default['tomcat8']['catalina_opts'] = '-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
# default['tomcat8']['java_opts'] = '-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

# default['national_parks']['seeddata']['chksum'] = '67b3c5ffeaecb5892ecccdf0d460d0cb'

# case node['platform_family']
# when 'debian', 'ubuntu'
#   default['national_parks']['cert']['home'] = '/etc/ssl'
# when 'centos', 'rhel', 'redhat', 'fedora', 'amazon'
#   default['national_parks']['cert']['home'] = '/etc/pki/tls'
# when 'windows'
#   default['national_parks']['cert']['home'] = 'c:\\'
# else
#   raise "Don't know which path to install digital certs for the family #{node['platform_family']}"
# end

# default['national_parks']['cert']['days'] = '365'
# default['national_parks']['cert']['subject'] = "/C=US/ST=Washington/L=Seattle/O=SA/CN=#{node['hostnamectl']['static_hostname']}"

# # if node['platform_family'] == 'windows'
# #   default['national_parks']['cert']['key'] = "#{node['national_parks']['cert']['home']}\\#{node['hostname']['static_hostname']}.key"
# #   default['national_parks']['cert']['crt'] = "#{node['national_parks']['cert']['home']}\\#{node['hostname']['static_hostname']}.crt"
# #   default['national_parks']['cert']['csr'] = "#{node['national_parks']['cert']['home']}\\#{node['hostname']['static_hostname']}.csr"  
# # else
# if node['platform_family'] != 'windows'
#   default['national_parks']['cert']['key'] = "#{node['national_parks']['cert']['home']}/private/#{node['hostnamectl']['static_hostname']}.key"
#   default['national_parks']['cert']['crt'] = "#{node['national_parks']['cert']['home']}/certs/#{node['hostnamectl']['static_hostname']}.crt"
#   default['national_parks']['cert']['csr'] = "#{node['national_parks']['cert']['home']}/certs/#{node['hostnamectl']['static_hostname']}.csr"
# end
