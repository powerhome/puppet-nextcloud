class nextcloud::php {
  apt::key { $::nextcloud::php_ppa_key: }
  apt::ppa { $::nextcloud::php_ppa:
    require => Apt::Key[$::nextcloud::php_ppa_key],
  }

  class { '::php::globals':
    php_version => $::nextcloud::php_version,
    config_root => "/etc/php/${::nextcloud::php_version}",
  }->
  class { '::php':
    manage_repos => false,
    fpm          => false,
    composer     => false,
    extensions   => {
        mysql     => {
          so_name => 'mysqli',
        },
        ldap      => {},
        zip       => {},
        gd        => {},
        xml       => {},
        xmlrpc    => {},
        curl      => {},
        mbstring  => {},
        intl      => {},
        mcrypt    => {},
        imap      => {},
        imagick   => {
          package_prefix => 'php-',
        },
        opcache   => {},
        bz2       => {},
        smbclient => {
          package_prefix => 'php-',
        },
        gmp       => {},
        apcu      => {
          package_prefix => 'php-',
        },
    },
    require      => Apt::Ppa[$::nextcloud::php_ppa],
  }
}
