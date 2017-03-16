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

  # Deploy permissions script
  file { $::nextcloud::permissions_script:
    ensure  => file,
    mode    => '0755',
    content => epp('nextcloud/permissions.sh.epp', {
        docroot   => $::nextcloud::docroot,
        www_user  => $::nextcloud::www_user,
        www_group => $::nextcloud::www_group,
    }),
    require => [Vcsrepo[$::nextcloud::docroot], Class['Apache']],
  }

  # Set ownership on the docroot
  exec { 'nextcloud_docroot':
    command => "/bin/bash ${nextcloud::permissions_script}",
    unless  => "/usr/bin/test ! -z \"$(/bin/ls -ltrhad ${::nextcloud::docroot} | /bin/grep 'root ${::nextcloud::www_group}')\"",
    require => File[$::nextcloud::permissions_script],
  }
}
