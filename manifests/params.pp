# Parameters for puppet-manuka
#
class manuka::params {
  include ::openstacklib::defaults
  $pyvers = $::openstacklib::defaults::pyvers

  $api_service_name            = 'manuka-api'
  $worker_service_name         = 'manuka-worker'
  $client_package_name         = "python${pyvers}-manukaclient"
  $group                       = 'manuka'

  case $::osfamily {
    'Debian': {
      $common_package_name         = 'manuka-common'
      $api_package_name            = 'manuka-api'
      $worker_package_name         = 'manuka-worker'
      $manuka_wsgi_script_path    = '/usr/lib/cgi-bin/manuka'
      $manuka_wsgi_script_source  = '/usr/bin/manuka-api'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
