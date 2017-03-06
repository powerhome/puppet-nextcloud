class nextcloud::repo {
  if $::nextcloud::repo_manage {
    apt::source { 'nextcloud':
      comment  => 'Nextcloud 11 server builds',
      location => $::nextcloud::repo_url,
      release  => 'xenial',
      repos    => 'main',
      pin      => '10',
      key      => {
        id     => $::nextcloud::repo_key_id,
        source => $::nextcloud::repo_key,
      },
      include  => {
        src => false,
        deb => true,
      },
    }
  }
}
