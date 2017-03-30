default['tomcat8']['archive_name'] = 'apache-tomcat-8.5.11.tar.gz'
default['tomcat8']['download_url'] = "http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.11/bin/#{default['tomcat8']['archive_name']}"
default['tomcat8']['install_location'] = '/opt/tomcat8.5'
default['tomcat8']['catalina_opts'] = '-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
default['tomcat8']['java_opts'] = '-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

default['national_parks']['seeddata']['chksum'] = '67b3c5ffeaecb5892ecccdf0d460d0cb'

default['national_parks']['cert']['days'] = '365'
default['national_parks']['cert']['subject'] = "/C=US/ST=Washington/L=Seattle/O=SA/CN=#{node['hostname']}.automate-demo.com"
default['national_parks']['cert']['key'] = "/etc/pki/tls/private/#{node['hostname']}.automate-demo.com.key"
default['national_parks']['cert']['crt'] = "/etc/pki/tls/certs/#{node['hostname']}.automate-demo.com.crt"