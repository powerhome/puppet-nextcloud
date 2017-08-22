class nextcloud::logs {

  # Create log file
  file { '/var/log/nextcloud.log':
    ensure => file,
    mode   => '0640',
    owner  => $::nextcloud::www_user,
    group  => $::nextcloud::www_group,
  }

  # Log rotation
  logrotate::rule { 'nextcloud':
    path         => '/var/log/nextcloud.log',
    rotate       => 5,
    rotate_every => 'day',
    create       => true,
    create_mode  => '0640',
    create_owner => $::nextcloud::www_user,
    create_group => $::nextcloud::www_group,
  }

}
