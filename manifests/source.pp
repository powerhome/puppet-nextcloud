class nextcloud::source {

  # Download and install a specific tagged release
  vcsrepo { $::nextcloud::docroot:
    ensure   => present,
    provider => git,
    source   => $::nextcloud::repo_url,
    revision => "v${::nextcloud::repo_version}",
  }
}
