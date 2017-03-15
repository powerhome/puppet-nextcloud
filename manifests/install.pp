class nextcloud::install {

  # Download and install a specific tagged release
  vcsrepo { $::nextcloud::docroot:
    ensure   => present,
    provider => git,
    source   => $::nextcloud::repo_url,
    revision => $::nextcloud::repo_tag,
  }

  # Set ownership on the docroot
  exec { 'nextcloud_docroot':
    command => "/usr/sbin/chown -R ${::nextcloud::www_user}:${::nextcloud::www_group} ${::nextcloud::docroot}",
    unless  => "/usr/bin/test ! -z \"$(/bin/ls -ltrhad ${::nextcloud::docroot} | /bin/grep '${::nextcloud::www_user} ${::nextcloud::www_group}')\"",
  }
}
