class nextcloud::php {

  apt::ppa { "${::nextcloud::php_ppa}": }
  $::nextcloud::php_ppa_keys.each |$key| {
    apt::key { $key:
      key => $key,
    }
  }

  class { '::php::globals':
    php_version => $::nextcloud::php_version,
    config_root => "/etc/php/${::nextcloud::php_version}",
  }->
  class { '::php':
    manage_repos => false,
    fpm          => true,
    composer     => false,
    extensions   => {
        mysql    => {
          so_name => 'mysqli',
        },
        ldap     => {},
        zip      => {},
        gd       => {},
        xml      => {},
        curl     => {},
        mbstring => {},
        intl     => {},
        mcrypt   => {},
        imap     => {},
    },
    require      => Apt::Ppa[$::nextcloud::php_ppa],
  }
}
