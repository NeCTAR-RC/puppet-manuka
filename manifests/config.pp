# == Class: manuka::config
#
# This class is used to manage arbitrary manuka configurations.
#
# === Parameters
#
# [*manuka_config*]
#   (optional) Allow configuration of arbitrary manuka configurations.
#   The value is an hash of manuka_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   manuka_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class manuka::config (
  $manuka_config = {},
) {

  include ::manuka::deps

  validate_legacy(Hash, 'validate_hash', $manuka_config)

  create_resources('manuka_config', $manuka_config)
}
