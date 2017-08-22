class nextcloud::docker {

  include ::docker

  file { "${nextcloud::base_dir}/data":
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0750',
    require => File[$base_dir],
  }

  docker::image { 'nextcloud':
    ensure    => present,
    image_tag => $::nextcloud::docker_image_tag,
  }

  docker::run { 'nextcloud':
    image   => 'nextcloud',
    ports   => [ '80:80' ],
    volumes => [
      "${::nextcloud::config_dir}:/var/www/html/config",
      "${::nextcloud::base_dir}/data:/var/www/html/data",
    ],
    require => Docker::Image['nextcloud'],
  }

}
