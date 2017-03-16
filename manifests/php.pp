class nextcloud::php {

  apt::ppa { 'ppa:ondrej/php': }

  class { '::php::globals':
    php_version => '7.0',
    config_root => '/etc/php/7.0',
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
  }
}
