name 'national_parks_cookbook'
maintainer 'Bill Meyer'
maintainer_email 'bill@chef.io'
license 'Apache-2.0'
description 'Installs/Configures national_parks'
long_description 'Installs/Configures national_parks'
version '0.1.18'
chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'centos'
supports 'redhat'
supports 'fedora'
supports 'amazon'
supports 'scientific'
supports 'oracle'

depends 'chocolatey'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/billmeyer/national_parks_cookbook/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/billmeyer/national_parks_cookbook' if respond_to?(:source_url)
