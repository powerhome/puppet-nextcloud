class nextcloud::install {

  # Data htaccess
  file { "${::nextcloud::base_dir}/data/.htaccess":
    ensure  => file,
    mode    => '0644',
    owner   => $::nextcloud::www_user,
    group   => $::nextcloud::www_group,
    content => epp('nextcloud/data_htaccess.epp'),
  }

  # OC data file
  file { "${::nextcloud::base_dir}/data/.ocdata":
    ensure => file,
    mode   => '0640',
    owner  => $::nextcloud::www_user,
    group  => $::nextcloud::www_group,
  }

  # Installation script
  file { $::nextcloud::install_script:
    ensure  => file,
    mode    => '0755',
    content => epp('nextcloud/install.sh.epp', {
      config_file  => $::nextcloud::config_file,
      db_user      => $::nextcloud::db_user,
      db_host      => $::nextcloud::db_host,
      db_name      => $::nextcloud::db_name,
      db_pass      => $::nextcloud::db_pass,
      admin_user   => $::nextcloud::admin_user,
      admin_passwd => $::nextcloud::admin_passwd,
    }),
  }

  if $nextcloud::deploy_method == 'traditional' {
    # Deploy permissions script
    file { $::nextcloud::permissions_script:
      ensure  => file,
      mode    => '0755',
      content => epp('nextcloud/permissions.sh.epp', {
          docroot   => $::nextcloud::docroot,
          www_user  => $::nextcloud::www_user,
          www_group => $::nextcloud::www_group,
      }),
    }
  }
}
