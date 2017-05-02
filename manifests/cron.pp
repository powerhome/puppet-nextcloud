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
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ config:list | grep \'"backgroundjobs_mode": "cron"\')"',
    require => Cron['nextcloud'],
  }

  # Cron job for cleaning up bruteforce attempts table
  if ($::role_instance == '1') {

    # Cron job for cleaning up bruteforce attempts table
    cron { 'nextcloud_clean_bruteforce':
      command => "/usr/bin/mysql -u ${::nextcloud::db_user} -p${::nextcloud::db_pass} -h ${::nextcloud::db_host} -e \"delete from ${::nextcloud::db_name}.oc_bruteforce_attempts\"",
      user    => 'root',
      hour    => 1,
      minute  => 0,
    }
  }
}
