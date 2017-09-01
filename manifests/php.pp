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
    manage_repos  => false,
    fpm           => false,
    composer      => false,
    apache_config => true,
    settings      => {
        'PHP/max_execution_time'                  => '3500',
        'PHP/max_input_time'                      => '3600',
        'PHP/memory_limit'                        => '512M',
        'PHP/post_max_size'                       => '1100M',
        'PHP/upload_max_filesize'                 => '1000M',
        'Date/date.timezone'                      => $::nextcloud::php_timezone,
        'opcache/opcache.enable'                  => '1',
        'opcache/opcache.enable_cli'              => '1',
        'opcache/opcache.interned_strings_buffer' => '8',
        'opcache/opcache.max_accelerated_files'   => '10000',
        'opcache/opcache.memory_consumption'      => '128',
        'opcache/opcache.save_comments'           => '1',
        'opcache/opcache.revalidate_freq'         => '1',
    },
    extensions    => {
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
        redis     => {
          package_prefix => 'php-',
        },
        intl      => {},
        mcrypt    => {},
        imap      => {},
        imagick   => {
          package_prefix => 'php-',
        },
        opcache   => {
          zend => true,
        },
        bz2       => {},
        smbclient => {
          package_prefix => 'php-',
        },
        gmp       => {},
        apcu      => {
          package_prefix => 'php-',
        },
    },
  }
}
