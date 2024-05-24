# == Class: manuka::db
#
#  Configure the manuka database
#
# === Parameters
#
# [*database_connection*]
#   (Optional) Url used to connect to database.
#   Defaults to 'sqlite:////var/lib/manuka/manuka.sqlite'.
#
# [*database_connection_recycle_time*]
#   (Optional) Timeout before idle SQL connections are reaped.
#   Defaults to $::os_service_default
#
class manuka::db (
  $database_connection              = 'sqlite:////var/lib/manuka/manuka.sqlite',
  $database_connection_recycle_time = $facts['os_service_default'],
) {

  include ::manuka::deps

  validate_legacy(Oslo::Dbconn, 'validate_re', $database_connection,
    ['^(sqlite|mysql(\+pymysql)?|postgresql):\/\/(\S+:\S+@\S+\/\S+)?'])

  oslo::db { 'manuka_config':
    connection              => $database_connection,
    connection_recycle_time => $database_connection_recycle_time,
  }

}
