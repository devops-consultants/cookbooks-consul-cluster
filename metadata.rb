name 'consul_cluster'
maintainer 'Rob Coward'
maintainer_email 'rob.coward@devops-consultants.co.uk'
license 'Apache-2.0'
description 'Installs/Configures consul_cluster'
long_description 'Installs/Configures consul_cluster'
version '0.1.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/base_server/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/base_server'

# depends 'users'
# depends 'os-hardening'
# depends 'chef-client'
# depends 'sudo'
# depends 'openssh'
# depends 'rsyslog'
# depends 'logrotate'
depends 'poise'#, '~> 2.2'
# depends 'poise-archive'#, '~> 1.3'
depends 'poise-service'#, '~> 1.4'
depends 'ark'