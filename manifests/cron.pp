class nextcloud::cron {

  # Nextcloud cron jobs
  cron { 'nextcloud':
    command => "/usr/bin/php -f ${::nextcloud::docroot}/cron.php",
    user    => $::nextcloud::www_user,
    minute  => '*/15',
  }

  # Make sure installation is using cron
  exec { 'nextcloud_cron':
    command => '/usr/bin/occ background:cron',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ config:list | grep '"backgroundjobs_mode": "cron"')"',
    require => Cron['nextcloud'],
  }
}
