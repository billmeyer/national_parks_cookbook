#
# Cookbook:: national_parks
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.8.0-openjdk'
package 'vim'
package 'git'

include_recipe 'national_parks::mongodb'
include_recipe 'national_parks::tomcat'
include_recipe 'national_parks::application'

