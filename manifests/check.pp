# = Define: sensu::check
#
# Defines Sensu checks
#
# == Parameters
#

define sensu::check(
  $command,
  $ensure               = 'present',
  $type                 = undef,
  $handlers             = [],
  $standalone           = undef,
  $interval             = '60',
  $subscribers          = [],
  $notification         = undef,
  $low_flap_threshold   = undef,
  $high_flap_threshold  = undef,
  $refresh              = undef,
  $aggregate            = undef,
  $config               = undef,
  $purge_config         = 'false',
) {

  if $purge_config {
    file { "/etc/sensu/conf.d/checks/${name}.json": ensure => $ensure, before => Sensu_check[$name] }
  }

  sensu_check { $name:
    ensure              => $ensure,
    type                => $type,
    standalone          => $standalone,
    command             => $command,
    handlers            => $handlers,
    interval            => $interval,
    subscribers         => $subscribers,
    notification        => $notification,
    low_flap_threshold  => $low_flap_threshold,
    high_flap_threshold => $high_flap_threshold,
    refresh             => $refresh,
    aggregate           => $aggregate,
    config              => $config,
    require             => File['/etc/sensu/conf.d/checks'],
  }

}
