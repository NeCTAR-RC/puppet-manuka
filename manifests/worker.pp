# Installs & configure the manuka controller worker service
#
# == Parameters
#
# [*enabled*]
#   (optional) Should the service be enabled.
#   Defaults to true
#
# [*freshdesk_domain*]
#   Freshdesk domain for creating contacts.
#
# [*freshdesk_key*]
#   Freshdesk API key
#
# [*manage_service*]
#   (optional) Whether the service should be managed by Puppet.
#   Defaults to true.
#
# [*package_ensure*]
#   (optional) ensure state for package.
#   Defaults to 'present'
#
# [*workers*]
#   (optional) Number of worker processes.
#    Defaults to $::os_service_default
#
class manuka::worker (
  $from_email,
  $freshdesk_domain,
  $freshdesk_key,
  $manage_service         = true,
  $enabled                = true,
  $package_ensure         = 'present',
  $workers                = $facts['os_workers'],
  $host                   = $facts['os_service_default'],
  $swift_default_quota_gb = $facts['os_service_default'],
  $smtp_host              = $facts['os_service_default'],
) inherits manuka::params {

  include ::manuka::deps

  package { 'manuka-worker':
    ensure => $package_ensure,
    name   => $::manuka::params::worker_package_name,
    tag    => ['nectar', 'manuka-package'],
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  service { 'manuka-worker':
    ensure     => $service_ensure,
    name       => $::manuka::params::worker_service_name,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => ['manuka-service'],
  }

  manuka_config {
    'DEFAULT/host':           value => $host;
    'worker/workers':         value => $workers;
    'swift/default_quota_gb': value => $swift_default_quota_gb;
    'smtp/host':              value => $smtp_host;
    'smtp/from_email':        value => $from_email;
    'freshdesk/domain':       value => $freshdesk_domain;
    'freshdesk/key':          value => $freshdesk_key;
  }
}
