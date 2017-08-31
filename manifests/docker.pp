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
    image   => 'wonderfall/nextcloud:11.0_beta',
    ports   => [ '80:8888' ],
    volumes => [
      '/opt/nextcloud_config:/config',
      '/opt/nextcloud/data:/data',
    ],
    env     => [
      'UPLOAD_MAX_SIZE=10G',
      'APC_SHM_SIZE=128M',
      'OPCACHE_MEM_SIZE=128',
      'CRON_PERIOD=15m',
      "TZ=${nextcloud::php_timezone}",
      "DOMAIN=${nextcloud::www_url}",
      "DATASTORE_BUCKET=${nextcloud::datastore_bucket}",
      "DATASTORE_KEY=${nextcloud::datastore_key}",
      "DATASTORE_SECRET=${nextcloud::datastore_secret}",
      "DATASTORE_HOST=${s3_storage_vip}",
      "DB_TYPE=${nextcloud::db_type}",
      "DB_NAME=${nextcloud::db_name}",
      "DB_USER=${nextcloud::db_user}",
      "DB_PASSWORD=${nextcloud::db_pass}",
      "DB_HOST=${nextcloud::db_host}",
      "ADMIN_USER=${nextcloud::admin_user}",
      "ADMIN_PASSWORD=${nextcloud::admin_passwd}",
    ], require => Docker::Image['nextcloud'],
  }

}
