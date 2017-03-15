class nextcloud::params {
  $repo_version  = '11.0.2'
  $repo_url      = 'git://github.com/nextcloud/server.git'
  $docroot       = '/var/www/nextcloud'
  $www_user      = 'www-data'
  $www_group     = 'www-data'
  $ssl_dir       = '/etc/ssl/nextcloud'
  $ssl_cert_path = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path  = "${ssl_dir}/nextcloud.key"
  $config_file   = "${docroot}/config/config.php"
}
