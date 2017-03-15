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
  class { 'apache::mod::ssl': }
  class { 'apache::mod::headers': }

  # Redirect requests to SSL
  apache::vhost { 'nextcloud-http':
    servername      => $::nextcloud::www_url,
    port            => '80',
    docroot         => $::nextcloud::docroot,
    redirect_status => 'permanent',
    redirect_dest   => "https://${::nextcloud::www_url}/",
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
    ssl_ca          => $::nextcloud::ssl_dir,
    options         => [
      '+FollowSymLinks',
    ],
    override        => [
      'All',
    ],
    setenv          => [
      "HOME ${::nextcloud::docroot}",
      "HTTP_HOME ${::nextcloud::docroot}"
    ],
    headers         => [
      'always set Strict-Transport-Security "max-age=15552000; includeSubDomains; preload"',
    ],
    require         => [File[$::nextcloud::ssl_cert_path], File[$::nextcloud::ssl_key_path]],
  }
}
