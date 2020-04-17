# == Class: manuka::db::postgresql
#
# Class that configures postgresql for manuka
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'manuka'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'manuka'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
class manuka::db::postgresql(
  $password,
  $dbname     = 'manuka',
  $user       = 'manuka',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  include ::manuka::deps

  ::openstacklib::db::postgresql { 'manuka':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  Anchor['manuka::db::begin']
  ~> Class['manuka::db::postgresql']
  ~> Anchor['manuka::db::end']

}
