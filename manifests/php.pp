class nextcloud::php {
  class { '::php::globals':
    php_version => '7.0',
    config_root => '/etc/php/7.0',
  }->
  class { '::php':
    manage_repos => true,
    extensions   => {
        mysql     => {},
        ldap      => {},
        zip       => {},
        dom       => {},
        xmlwriter => {},
        xmlreader => {},
        gd        => {},
        curl      => {},
        mbstring  => {},
    },
  }
}
