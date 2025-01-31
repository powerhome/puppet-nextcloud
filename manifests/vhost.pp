class nextcloud::vhost {

  # SSL certificate directory
  file { $::nextcloud::ssl_dir:
    ensure => directory,
  }

  # SSL certificate file
  file { $::nextcloud::ssl_cert_path:
    ensure  => file,
    content => $::nextcloud::ssl_cert,
    require => File[$::nextcloud::ssl_dir],
  }

  # SSL key file
  file { $::nextcloud::ssl_key_path:
    ensure  => file,
    content => $::nextcloud::ssl_key,
    require => File[$::nextcloud::ssl_dir],
  }

  # Required Apache modules
  $::nextcloud::apache_enabled_mods.each |$enmod| {
    class { "apache::mod::${enmod}": }
  }

  # Custom install of PHP module
  apache::mod { 'php7.0':
    package => 'libapache2-mod-php7.0',
    lib     => 'libphp7.0.so',
    id      => 'php7_module',
  }

  # Redirect requests to SSL
  apache::vhost { 'nextcloud-http':
    port            => '80',
    docroot         => $::nextcloud::docroot,
    manage_docroot  => false,
    servername      => $::nextcloud::www_url,
    directories     => [
      {
        path            => $::nextcloud::docroot,
        options         => ['+FollowSymLinks'],
        allow_override  => ['All'],
        directoryindex  => 'index.php',
        setenv          => [
          "HOME ${::nextcloud::docroot}",
          "HTTP_HOME ${::nextcloud::docroot}"
        ],
        custom_fragment => join([
          '',
          '    <IfModule mod_dav.c>',
          '      Dav off',
          '    </IfModule>'
        ], "\n"),
      },
    ],
    headers         => [
      'always set Strict-Transport-Security "max-age=15552000; includeSubDomains; preload"',
    ],
    custom_fragment => 'AddType application/x-httpd-php .php',
    require         => [File[$::nextcloud::ssl_cert_path], File[$::nextcloud::ssl_key_path]],
  }

  apache::vhost { 'nextcloud-https':
    port            => '443',
    docroot         => $::nextcloud::docroot,
    manage_docroot  => false,
    servername      => $::nextcloud::www_url,
    ssl             => true,
    ssl_cert        => $::nextcloud::ssl_cert_path,
    ssl_key         => $::nextcloud::ssl_key_path,
    ssl_ca          => $::nextcloud::ssl_cert_path,
    directories     => [
      {
        path            => $::nextcloud::docroot,
        options         => ['+FollowSymLinks'],
        allow_override  => ['All'],
        directoryindex  => 'index.php',
        setenv          => [
          "HOME ${::nextcloud::docroot}",
          "HTTP_HOME ${::nextcloud::docroot}"
        ],
        custom_fragment => join([
          '',
          '    <IfModule mod_dav.c>',
          '      Dav off',
          '    </IfModule>'
        ], "\n"),
      },
    ],
    headers         => [
      'always set Strict-Transport-Security "max-age=15552000; includeSubDomains; preload"',
    ],
    custom_fragment => 'AddType application/x-httpd-php .php',
    require         => [File[$::nextcloud::ssl_cert_path], File[$::nextcloud::ssl_key_path]],
  }
}
