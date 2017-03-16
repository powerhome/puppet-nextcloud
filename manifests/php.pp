class nextcloud::php {

  apt::ppa { "${::nextcloud::php_ppa}": }
  apt::key { "${::nextcloud::php_ppa}":
    key => $::nextcloud::php_ppa_key,
  }

  class { '::php::globals':
    php_version => $::nextcloud::php_version,
    config_root => "/etc/php/${::nextcloud::php_version}",
  }->
  class { '::php':
    manage_repos => false,
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
    require      => [Apt::Ppa[$::nextcloud::php_ppa], Apt::Key[$::nextcloud::php_ppa]]
  }
}
