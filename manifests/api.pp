# Installs & configure the manuka service
#
# == Parameters
#
# [*enabled*]
#   (optional) Should the service be enabled.
#   Defaults to true
#
# [*manage_service*]
#   (optional) Whether the service should be managed by Puppet.
#   Defaults to true.
#
# [*service_name*]
#   (Optional) Name of the service that will be providing the
#   server functionality of manuka-api.
#   If the value is 'httpd', this means manuka-api will be a web
#   service, and you must use another class to configure that
#   web service. For example, use class { 'manuka::wsgi::apache'...}
#   to make manuka-api be a web app using apache mod_wsgi.
#   Defaults to $::manuka::params::api_service_name
#
# [*host*]
#   (optional) The manuka api bind address.
#   Defaults to '0.0.0.0'
#
# [*port*]
#   (optional) The manuka api port.
#   Defaults to '9876'
#
class manuka::api (
  $default_target,
  $enabled                        = true,
  $manage_service                 = true,
  $service_name                   = $::manuka::params::api_service_name,
  $host                           = $::os_service_default,
  $port                           = $::os_service_default,
  $package_ensure                 = 'present',
  $idp_domain_mapping_dir         = $::os_service_default,
  $whitelist                      = [],
  $fake_shib                      = $::os_service_default,
) inherits manuka::params {

  include ::manuka::deps
  include ::manuka::db
  include ::manuka::keystone::authtoken

  package { 'manuka-api':
    ensure => $package_ensure,
    name   => $::manuka::params::api_package_name,
    tag    => ['openstack', 'manuka-package'],
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }

    if $service_name == $::manuka::params::api_service_name {
      service { 'manuka-api':
        ensure     => $service_ensure,
        name       => $::manuka::params::api_service_name,
        enable     => $enabled,
        hasstatus  => true,
        hasrestart => true,
        tag        => ['manuka-service'],
      }
    } elsif $service_name == 'httpd' {
      include ::apache::params
      service { 'manuka-api':
        ensure => 'stopped',
        name   => $::manuka::params::api_service_name,
        enable => false,
        tag    => ['manuka-service'],
      }
      Service['manuka-api'] -> Service[$service_name]
      Service<| title == 'httpd' |> { tag +> ['manuka-service'] }
    }
  }

  manuka_config {
    'DEFAULT/idp_domain_mapping_dir':    value => $idp_domain_mapping_dir;
    'DEFAULT/default_target':            value => $default_target;
    'DEFAULT/whitelist':                 value => join($whitelist, ',');
    'DEFAULT/fake_shib':                 value => $fake_shib;
    'flask/host':                        value => $host;
    'flask/port':                        value => $host;
  }
}
