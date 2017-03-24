class nextcloud::config {

  # Deploy the NextCloud configuration
  file { $::nextcloud::config_file:
    ensure  => file,
    owner   => $::nextcloud::www_user,
    group   => $::nextcloud::www_group,
    content => epp('nextcloud/config.php.epp', {
        instance_id       => $::nextcloud::instance_id,
        instance_salt     => $::nextcloud::instance_salt,
        instance_secret   => $::nextcloud::instance_secret,
        www_url           => $::nextcloud::www_url,
        docroot           => $::nextcloud::docroot,
        installed_version => $::nextcloud::installed_version,
        db_name           => $::nextcloud::db_name,
        db_user           => $::nextcloud::db_user,
        db_pass           => $::nextcloud::db_pass,
        db_host           => $::nextcloud::db_host,
        datastore_bucket  => $::nextcloud::datastore_bucket,
        datastore_url     => $::nextcloud::datastore_url,
        datastore_key     => $::nextcloud::datastore_key,
        datastore_secret  => $::nextcloud::datastore_secret,
        mail_from         => $::nextcloud::mail_from,
        mail_domain       => $::nextcloud::mail_domain,
        mail_host         => $::nextcloud::mail_host,
        mail_port         => $::nextcloud::mail_port,
        mail_pass         => $::nextcloud::mail_pass,
        redis_server      => $::nextcloud::redis_server,
        redis_port        => $::nextcloud::redis_port,
    }),
    notify  => Service['httpd'],
  }
}
