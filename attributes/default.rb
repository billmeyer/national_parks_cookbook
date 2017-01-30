default['tomcat8']['archive_name'] = 'apache-tomcat-8.5.9.tar.gz'
default['tomcat8']['download_url'] = "http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/#{default['tomcat8']['archive_name']}"
default['tomcat8']['install_location'] = '/opt/tomcat8.5'
default['tomcat8']['catalina_opts'] = '-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
default['tomcat8']['java_opts'] = '-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

default['national_parks']['seeddata']['chksum'] = '67b3c5ffeaecb5892ecccdf0d460d0cb'
