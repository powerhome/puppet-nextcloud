class nextcloud::service {

  case $nextcloud::deploy_method {
    default: {
      $occ_require_class = 'nextcloud::updates'
    }
    'docker': {
      $occ_require_class = 'nextcloud::docker'
    }
  }

  # Deploy command line tool wrapper
  file { '/usr/bin/occ':
    ensure  => file,
    mode    => '0755',
    content => epp('nextcloud/occ.epp', {
        deploy_method => $nextcloud::deploy_method,
        docroot       => $::nextcloud::docroot,
        www_user      => $::nextcloud::www_user,
    }),
    require => Class[$occ_require_class],
  }

  case $nextcloud::deploy_method {
    default: {
      class { 'mysql::client': } ->
      class { 'nextcloud::source': } ->
      class { 'nextcloud::apache': } ->
      class { 'nextcloud::php': } ->
      class { 'nextcloud::logs': } ->
      class { 'nextcloud::install': } ->
      class { 'nextcloud::vhost': } ->
      class { 'nextcloud::updates': }
    }
    'docker': {
      class { 'nextcloud::docker': } ->
      class { 'nextcloud::install': }
    }
  }
}
