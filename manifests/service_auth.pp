#
# Configures credentials for service to service communication.
#
# === Parameters:
#
# [*auth_url*]
#   (optional) Keystone Authentication URL
#   Defaults to $::os_service_default
#
# [*username*]
#   (optional) User for accessing neutron and other services.
#   Defaults to $::os_service_default
#
# [*project_name*]
#   (optional) Tenant for accessing neutron and other services
#   Defaults to $::os_service_default
#
# [*password*]
#   (optional) Password for user
#   Defaults to $::os_service_default
#
# [*user_domain_name*]
#   (optional) keystone user domain
#   Defaults to $::os_service_default
#
# [*project_domain_name*]
#   (optional) keystone project domain
#   Defaults to $::os_service_default
#
# [*auth_type*]
#   (optional) keystone authentication type
#   Defaults to $::os_service_default
#

class manuka::service_auth (
  $auth_url            = $facts['os_service_default'],
  $username            = $facts['os_service_default'],
  $project_name        = $facts['os_service_default'],
  $password            = $facts['os_service_default'],
  $user_domain_name    = $facts['os_service_default'],
  $project_domain_name = $facts['os_service_default'],
  $auth_type           = $facts['os_service_default'],
) {

  include ::manuka::deps

  manuka_config {
    'service_auth/auth_url'            : value => $auth_url;
    'service_auth/username'            : value => $username;
    'service_auth/project_name'        : value => $project_name;
    'service_auth/password'            : value => $password;
    'service_auth/user_domain_name'    : value => $user_domain_name;
    'service_auth/project_domain_name' : value => $project_domain_name;
    'service_auth/auth_type'           : value => $auth_type;
  }
}
