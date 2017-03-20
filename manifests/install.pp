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

  # Install command line parameters
  $install_db = "--database \"mysql\" --database-host \"${::nextcloud::db_host}\" --database-name \"${::nextcloud::db_name}\" --database-user \"${::nextcloud::db_user}\" --database-pass \"${::nextcloud::db_pass}\""
  $install_admin = "--admin-user \"${::nextcloud::admin_user}\" --admin-pass \"${::nextcloud::admin_passwd}\""

  # Run installation
  exec { 'nextcloud_install':
    command => "/usr/bin/occ maintenance:install --data-dir \"${::nextcloud::data_dir}\" ${install_db} ${install_admin}",
    unless  => '/usr/bin/test -z "$(/usr/bin/occ status | /bin/grep "installed: false")"',
    require => File['/usr/bin/occ'],
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
