#
# Cookbook:: national_parks_cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  apt_update 'update'
end

package 'vim'
package 'git'

include_recipe 'national_parks_cookbook::java'
include_recipe 'national_parks_cookbook::mongodb'
include_recipe 'national_parks_cookbook::tomcat'
include_recipe 'national_parks_cookbook::ssl'
include_recipe 'national_parks_cookbook::application'
