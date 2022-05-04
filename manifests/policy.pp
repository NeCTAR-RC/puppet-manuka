# == Class: manuka::policy
#
# Configure the manuka policies
#
# === Parameters
#
# [*policies*]
#   (Optional) Set of policies to configure for manuka
#   Example :
#     {
#       'manuka-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'manuka-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (Optional) Path to the nova policy.json file
#   Defaults to /etc/manuka/policy.json
#
class manuka::policy (
  $policies    = {},
  $policy_path = '/etc/manuka/policy.yaml',
) {

  include manuka::deps
  include manuka::params

  validate_legacy(Hash, 'validate_hash', $policies)

  Openstacklib::Policy::Base {
    file_path  => $policy_path,
    file_user  => 'root',
    file_group => $manuka::params::group,
    file_format => 'yaml',
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'manuka_config': policy_file => $policy_path }

}
