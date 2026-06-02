# == Class: manuka
#
# Full description of class manuka here.
#
# === Parameters
#
# [*package_ensure*]
#   (optional) The state of manuka packages
#   Defaults to 'present'
#
# [*default_transport_url*]
#    (optional) A URL representing the messaging driver to use and its full
#    configuration. Transport URLs take the form:
#      transport://user:pass@host1:port[,hostN:portN]/virtual_host
#    Defaults to $::os_service_default
#
# [*rpc_response_timeout*]
#  (Optional) Seconds to wait for a response from a call.
#  Defaults to $::os_service_default
#
# [*control_exchange*]
#   (Optional) The default exchange under which topics are scoped. May be
#   overridden by an exchange name specified in the transport_url
#   option.
#   Defaults to $::os_service_default
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ
#   Defaults to $::os_service_default
#
# [*rabbit_ha_queues*]
#   (optional) Use HA queues in RabbitMQ.
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   (Requires kombu >= 3.0.7 and amqp >= 1.4.0)
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period to
#   check the heartbeat on RabbitMQ connection.  (i.e. rabbit_heartbeat_rate=2
#   when rabbit_heartbeat_timeout_threshold=60, the heartbeat will be checked
#   every 30 seconds.
#   Defaults to $::os_service_default
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions.
#   Defaults to $::os_service_default
#
# [*kombu_reconnect_delay*]
#   (optional) How long to wait before reconnecting in response to an AMQP
#   consumer cancel notification.
#   Defaults to '$::os_service_default
#
# [*kombu_failover_strategy*]
#   (Optional) Determines how the next RabbitMQ node is chosen in case the one
#   we are currently connected to becomes unavailable. Takes effect only if
#   more than one RabbitMQ node is provided in config. (string value)
#   Defaults to $::os_service_default
#
# [*kombu_compression*]
#   (optional) Possible values are: gzip, bz2. If not set compression will not
#   be used. This option may notbe available in future versions. EXPERIMENTAL.
#   (string value)
#   Defaults to $::os_service_default
#
# [*amqp_durable_queues*]
#   (optional) Define queues as "durable" to rabbitmq.
#   Defaults to $::os_service_default
#
# [*notification_transport_url*]
#   (optional) A URL representing the messaging driver to use for notifications
#   and its full configuration. Transport URLs take the form:
#     transport://user:pass@host1:port[,hostN:portN]/virtual_host
#   Defaults to $::os_service_default
#
# [*notification_driver*]
#   (optional) Driver or drivers to handle sending notifications.
#   Value can be a string or a list.
#   Defaults to $::os_service_default
#
# [*notification_topics*]
#   (optional) AMQP topic used for OpenStack notifications
#   Defaults to $::os_service_default
#
# [*purge_config*]
#   (optional) Whether to set only the specified config options
#   in the manuka config.
#   Defaults to false.
#
# [*database_connection*]
#   (Optional) Url used to connect to database.
#   Defaults to undef.
#
# [*database_idle_timeout*]
#   (Optional) Timeout when db connections should be reaped.
#   Defaults to undef.
#
# [*database_max_retries*]
#   (Optional) Maximum number of database connection retries during startup.
#   Setting -1 implies an infinite retry count.
#   Defaults to undef.
#
# [*database_retry_interval*]
#   (Optional) Interval between retries of opening a database connection.
#   Defaults to undef.
#
# [*database_min_pool_size*]
#   (Optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_pool_size*]
#   (Optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_overflow*]
#   (Optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to undef.
#
# [*database_pool_timeout*]
#   (Optional) If set, use this value for pool_timeout with SQLAlchemy.
#   Defaults to undef.
#
# [*database_db_max_retries*]
#   (Optional) Maximum retries in case of connection error or deadlock error
#   before error is raised. Set to -1 to specify an infinite retry count.
#   Defaults to undef.
#
# [*orcid_key*]
#   API key for Orcid service
#
# [*orcid_secret*]
#   Secret corresponding to the orcid API key
#
# [*orcid_sandbox*]
#   If 'True', use the Orcid sandbox service rather than the production service
#
# [*orcid_http_proxy*]
#   Use this proxy URL when talking http to the ORCID service
#
# [*orcid_https_proxy*]
#   Use this proxy URL when talking https to the ORCID service
#
# [*orcid_timeout*]
#   Use this timout (seconds) when talking to the ORCID service

class manuka (
  $support_url,
  $secret_key,
  $authenticate_password,
  $auth_url,
  $orcid_key,
  $orcid_secret,
  $orcid_sandbox                      = $facts['os_service_default'],
  $orcid_http_proxy                   = $facts['os_service_default'],
  $orcid_https_proxy                  = $facts['os_service_default'],
  $orcid_timeout                      = $facts['os_service_default'],
  $package_ensure                     = 'present',
  $default_transport_url              = $facts['os_service_default'],
  $rpc_response_timeout               = $facts['os_service_default'],
  $control_exchange                   = $facts['os_service_default'],
  $rabbit_use_ssl                     = $facts['os_service_default'],
  $rabbit_heartbeat_timeout_threshold = $facts['os_service_default'],
  $rabbit_heartbeat_rate              = $facts['os_service_default'],
  $rabbit_ha_queues                   = $facts['os_service_default'],
  $rabbit_quorum_queue                = $facts['os_service_default'],
  $rabbit_transient_quorum_queue      = $facts['os_service_default'],
  $rabbit_stream_fanout               = $facts['os_service_default'],
  $rabbit_qos_prefetch_count          = $facts['os_service_default'],
  $kombu_ssl_ca_certs                 = $facts['os_service_default'],
  $kombu_ssl_certfile                 = $facts['os_service_default'],
  $kombu_ssl_keyfile                  = $facts['os_service_default'],
  $kombu_ssl_version                  = $facts['os_service_default'],
  $kombu_reconnect_delay              = $facts['os_service_default'],
  $kombu_failover_strategy            = $facts['os_service_default'],
  $kombu_compression                  = $facts['os_service_default'],
  $amqp_durable_queues                = $facts['os_service_default'],
  $notification_transport_url         = $facts['os_service_default'],
  $notification_driver                = $facts['os_service_default'],
  $notification_topics                = $facts['os_service_default'],
  $purge_config                       = false,
  $database_connection                = undef,
  $database_idle_timeout              = undef,
  $database_min_pool_size             = undef,
  $database_max_pool_size             = undef,
  $database_max_retries               = undef,
  $database_retry_interval            = undef,
  $database_max_overflow              = undef,
  $database_pool_timeout              = undef,
  $database_db_max_retries            = undef,
  $terms_version                      = $facts['os_service_default'],
) inherits manuka::params {

  include ::manuka::deps
  include ::manuka::db

  package { 'manuka':
    ensure => $package_ensure,
    name   => $::manuka::params::common_package_name,
    tag    => ['nectar', 'manuka-package'],
  }

  resources { 'manuka_config':
    purge => $purge_config,
  }

  oslo::messaging::rabbit { 'manuka_config':
    rabbit_ha_queues              => $rabbit_ha_queues,
    heartbeat_timeout_threshold   => $rabbit_heartbeat_timeout_threshold,
    heartbeat_rate                => $rabbit_heartbeat_rate,
    rabbit_use_ssl                => $rabbit_use_ssl,
    kombu_reconnect_delay         => $kombu_reconnect_delay,
    kombu_failover_strategy       => $kombu_failover_strategy,
    kombu_ssl_version             => $kombu_ssl_version,
    kombu_ssl_keyfile             => $kombu_ssl_keyfile,
    kombu_ssl_certfile            => $kombu_ssl_certfile,
    kombu_ssl_ca_certs            => $kombu_ssl_ca_certs,
    kombu_compression             => $kombu_compression,
    amqp_durable_queues           => $amqp_durable_queues,
    rabbit_quorum_queue           => $rabbit_quorum_queue,
    rabbit_transient_quorum_queue => $rabbit_transient_quorum_queue,
    rabbit_stream_fanout          => $rabbit_stream_fanout,
    rabbit_qos_prefetch_count     => $rabbit_qos_prefetch_count,
  }

  oslo::messaging::default { 'manuka_config':
    transport_url        => $default_transport_url,
    rpc_response_timeout => $rpc_response_timeout,
    control_exchange     => $control_exchange,
  }

  oslo::messaging::notifications { 'manuka_config':
    transport_url => $notification_transport_url,
    driver        => $notification_driver,
    topics        => $notification_topics,
  }

  manuka_config {
    'DEFAULT/terms_version':             value => $terms_version;
    'DEFAULT/support_url':               value => $support_url;
    'flask/secret_key':                  value => $secret_key;
    'keystone/authenticate_password':    value => $authenticate_password;
    'keystone/auth_url':                 value => $auth_url;
    'orcid/key':                         value => $orcid_key;
    'orcid/secret':                      value => $orcid_secret;
    'orcid/sandbox':                     value => $orcid_sandbox;
    'orcid/http_proxy':                  value => $orcid_http_proxy;
    'orcid/https_proxy':                 value => $orcid_https_proxy;
    'orcid/timeout':                     value => $orcid_timeout;
  }
}
