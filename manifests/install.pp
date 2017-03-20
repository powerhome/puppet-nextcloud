class nextcloud::install {

  # Download and install a specific tagged release
  vcsrepo { $::nextcloud::docroot:
    ensure   => present,
    provider => git,
    source   => $::nextcloud::repo_url,
    revision => "v${::nextcloud::repo_version}",
  }

  # Install Apache
  class { 'apache':
    default_vhost => false,
    mpm_module    => 'prefork',
  }

  # We need MySQL command line client
  package { 'mysql-client':
    ensure => present,
  }

  # Deploy command line tool wrapper
  file { '/usr/bin/occ':
    ensure  => file,
    mode    => '0755',
    content => epp('nextcloud/occ.epp', {
        docroot  => $::nextcloud::docroot,
        www_user => $::nextcloud::www_user,
    }),
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

  # Run installation
  exec { 'nextcloud_install':
    command => "/bin/bash ${::nextcloud::install_script}",
    unless  => '/usr/bin/test -z "$(/usr/bin/occ status | /bin/grep "installed: false")"',
    require => [File['/usr/bin/occ'], File[$::nextcloud::install_script], File[$::nextcloud::config_file]],
  }

  # Deploy permissions script
  file { $::nextcloud::permissions_script:
    ensure  => file,
    mode    => '0755',
    content => epp('nextcloud/permissions.sh.epp', {
        docroot   => $::nextcloud::docroot,
        www_user  => $::nextcloud::www_user,
        www_group => $::nextcloud::www_group,
    }),
    require => [Vcsrepo[$::nextcloud::docroot], Package['httpd']],
  }

  # Set ownership on the docroot
  exec { 'nextcloud_docroot':
    command => "/bin/bash ${nextcloud::permissions_script}",
    unless  => "/usr/bin/test ! -z \"$(/bin/ls -ltrhad ${::nextcloud::docroot} | /bin/grep 'root ${::nextcloud::www_group}')\"",
    require => File[$::nextcloud::permissions_script],
  }
}
