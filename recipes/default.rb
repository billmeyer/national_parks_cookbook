#
# Cookbook:: national_parks
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.8.0-openjdk'
package 'vim'
package 'git'

include_recipe 'national_parks_cookbook::mongodb'
include_recipe 'national_parks_cookbook::tomcat'
include_recipe 'national_parks_cookbook::ssl'
include_recipe 'national_parks_cookbook::application'

