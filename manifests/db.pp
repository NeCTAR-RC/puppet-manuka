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
# [*database_connection_pool_recycle*]
#   (Optional) Connections which have been present in the connection pool longer
#   than this number of seconds will be replaced with a new one the next time
#   they are checked out from the pool.
#   Defaults to $::os_service_default
#
# [*database_max_retries*]
#   (Optional) Maximum number of database connection retries during startup.
#   Setting -1 implies an infinite retry count.
#   Defaults to $::os_service_default
#
# [*database_retry_interval*]
#   (Optional) Interval between retries of opening a database connection.
#   Defaults to $::os_service_default
#
# [*database_min_pool_size*]
#   (Optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to $::os_service_default
#
# [*database_max_pool_size*]
#   (Optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to $::os_service_default
#
# [*database_max_overflow*]
#   (Optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to $::os_service_default
#
# [*database_pool_timeout*]
#   (Optional) If set, use this value for pool_timeout with SQLAlchemy.
#   Defaults to $::os_service_default
#
# [*database_db_max_retries*]
#   (Optional) Maximum retries in case of connection error or deadlock error
#   before error is raised. Set to -1 to specify an infinite retry count.
#   Defaults to $::os_service_default
#
class manuka::db (
  $database_connection              = 'sqlite:////var/lib/manuka/manuka.sqlite',
  $database_connection_pool_recycle = $::os_service_default,
  $database_min_pool_size           = $::os_service_default,
  $database_max_pool_size           = $::os_service_default,
  $database_max_retries             = $::os_service_default,
  $database_retry_interval          = $::os_service_default,
  $database_max_overflow            = $::os_service_default,
  $database_pool_timeout            = $::os_service_default,
  $database_db_max_retries          = $::os_service_default,
) {

  include ::manuka::deps

  validate_legacy(Oslo::Dbconn, 'validate_re', $database_connection_real,
    ['^(sqlite|mysql(\+pymysql)?|postgresql):\/\/(\S+:\S+@\S+\/\S+)?'])

  oslo::db { 'manuka_config':
    connection              => $database_connection,
    connection_pool_recycle => $database_connection_pool_recycle,
    min_pool_size           => $database_min_pool_size,
    max_pool_size           => $database_max_pool_size,
    max_retries             => $database_max_retries,
    retry_interval          => $database_retry_interval,
    max_overflow            => $database_max_overflow,
    pool_timeout            => $database_pool_timeout,
    db_max_retries          => $database_db_max_retries,
  }

}
