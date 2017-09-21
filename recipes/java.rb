#
# Cookbook:: national_parks_cookbook
# Recipe:: java
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  package 'openjdk-8-jdk'

  node.normal['national_parks_cookbook']['java_home'] =
    case node['platform']
    when 'ubuntu'
      '/usr/lib/jvm/java-8-openjdk-amd64/jre'
    else
      '/usr/lib/jvm/java-8-openjdk-armhf/jre'
    end

when 'centos', 'rhel', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
  package 'java-1.8.0-openjdk'
  package 'java-1.8.0-openjdk-devel'

  if node['platform_version'].start_with?('6.')
    node.normal['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/java-1.8.0-openjdk.x86_64'
  elsif node['platform_version'].start_with?('7.')
    node.normal['national_parks_cookbook']['java_home'] = '/usr/lib/jvm/jre'
  end

when 'windows'
  chocolatey_package 'jdk8'
else
  raise "Don't know which java package to install for the family #{node['platform_family']}"
end
