#
# Cookbook:: national_parks_cookbook
# Recipe:: java
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  package 'openjdk-8-jdk'
  node.set['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/java-8-openjdk-armhf/jre'
when 'centos', 'rhel', 'redhat', 'fedora', 'amazon'
  package 'java-1.8.0-openjdk'
  node.set['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/jre'
else
  raise "Don't know which java package to install for the family #{node['platform_family']}"
end
