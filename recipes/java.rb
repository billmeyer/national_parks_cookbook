#
# Cookbook:: national_parks_cookbook
# Recipe:: java
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  package 'openjdk-8-jdk'

  case node['platform']
  when 'ubuntu'
    node.set['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/java-8-openjdk-amd64/jre'
  else
    node.set['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/java-8-openjdk-armhf/jre'
  end

when 'centos', 'rhel', 'redhat', 'fedora', 'amazon'
  package 'java-1.8.0-openjdk'
  node.set['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/jre'
when 'windows'
  chocolatey_package 'jdk8'
else
  raise "Don't know which java package to install for the family #{node['platform_family']}"
end
