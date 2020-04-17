# == Class: manuka::keystone::auth
#
# Configures manuka user, service and endpoint in Keystone.
#
# === Parameters
#
# [*password*]
#   (Required) Password for manuka user.
#
# [*auth_name*]
#   (Optional) Username for manuka service.
#   Defaults to 'manuka'.
#
# [*email*]
#   (Optional) Email for manuka user.
#   Defaults to 'manuka@localhost'.
#
# [*tenant*]
#   (Optional) Tenant for manuka user.
#   Defaults to 'services'.
#
# [*configure_endpoint*]
#   (Optional) Should manuka endpoint be configured?
#   Defaults to true.
#
# [*configure_user*]
#   (Optional) Should the service user be configured?
#   Defaults to true.
#
# [*configure_user_role*]
#   (Optional) Should the admin role be configured for the service user?
#   Defaults to true.
#
# [*service_type*]
#   (Optional) Type of service.
#   Defaults to 'load-balancer'.
#
# [*region*]
#   (Optional) Region for endpoint.
#   Defaults to 'RegionOne'.
#
# [*service_name*]
#   (Optional) Name of the service.
#   Defaults to 'manuka'
#
# [*service_description*]
#   (Optional) Description of the service.
#   Default to 'Octavia Service'
#
# [*public_url*]
#   (0ptional) The endpoint's public url.
#   This url should *not* contain any trailing '/'.
#   Defaults to 'http://127.0.0.1:9876'
#
# [*admin_url*]
#   (Optional) The endpoint's admin url.
#   This url should *not* contain any trailing '/'.
#   Defaults to 'http://127.0.0.1:9876'
#
# [*internal_url*]
#   (Optional) The endpoint's internal url.
#   This url should *not* contain any trailing '/'.
#   Defaults to 'http://127.0.0.1:9876'
#
class manuka::keystone::auth (
  $password,
  $auth_name           = 'manuka',
  $email               = 'manuka@localhost',
  $tenant              = 'services',
  $configure_endpoint  = true,
  $configure_user      = true,
  $configure_user_role = true,
  $service_description = 'Octavia Service',
  $service_name        = 'manuka',
  $service_type        = 'load-balancer',
  $region              = 'RegionOne',
  $public_url          = 'http://127.0.0.1:9876',
  $admin_url           = 'http://127.0.0.1:9876',
  $internal_url        = 'http://127.0.0.1:9876',
) {

  include ::manuka::deps

  keystone::resource::service_identity { 'manuka':
    configure_user      => $configure_user,
    configure_user_role => $configure_user_role,
    configure_endpoint  => $configure_endpoint,
    service_name        => $service_name,
    service_type        => $service_type,
    service_description => $service_description,
    region              => $region,
    auth_name           => $auth_name,
    password            => $password,
    email               => $email,
    tenant              => $tenant,
    public_url          => $public_url,
    internal_url        => $internal_url,
    admin_url           => $admin_url,
  }

}
