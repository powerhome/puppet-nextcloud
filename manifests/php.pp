class nextcloud::php {
  class { '::php::globals':
    php_version => $::nextcloud::php_version,
    config_root => "/etc/php/${::nextcloud::php_version}",
  }->
  class { '::php':
    manage_repos => true,
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
  }
}
