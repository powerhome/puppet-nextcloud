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

  # Set ownership on the docroot
  exec { 'nextcloud_docroot':
    command => "/bin/chown -R ${::nextcloud::www_user}:${::nextcloud::www_group} ${::nextcloud::docroot}",
    unless  => "/usr/bin/test ! -z \"$(/bin/ls -ltrhad ${::nextcloud::docroot} | /bin/grep '${::nextcloud::www_user} ${::nextcloud::www_group}')\"",
  }
}
