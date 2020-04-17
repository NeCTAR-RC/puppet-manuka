# == Class: manuka::deps
#
#  Manuka anchors and dependency management
#
class manuka::deps {
  # Setup anchors for install, config and service phases of the module.  These
  # anchors allow external modules to hook the begin and end of any of these
  # phases.  Package or service management can also be replaced by ensuring the
  # package is absent or turning off service management and having the
  # replacement depend on the appropriate anchors.  When applicable, end tags
  # should be notified so that subscribers can determine if installation,
  # config or service state changed and act on that if needed.
  anchor { 'manuka::install::begin': }
  -> Package<| tag == 'manuka-package'|>
  ~> anchor { 'manuka::install::end': }
  -> anchor { 'manuka::config::begin': }
  -> Manuka_config<||>
  ~> anchor { 'manuka::config::end': }
  -> anchor { 'manuka::db::begin': }
  -> anchor { 'manuka::db::end': }
  ~> anchor { 'manuka::service::begin': }
  ~> Service<| tag == 'manuka-service' |>
  ~> anchor { 'manuka::service::end': }

  # policy config should occur in the config block also.
  Anchor['manuka::config::begin']
  -> Openstacklib::Policy::Base<||>
  ~> Anchor['manuka::config::end']

  # Installation or config changes will always restart services.
  Anchor['manuka::install::end'] ~> Anchor['manuka::service::begin']
  Anchor['manuka::config::end']  ~> Anchor['manuka::service::begin']

}
