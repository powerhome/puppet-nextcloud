class nextcloud::params {
  $repo_version       = '11.0.2'
  $repo_url           = 'git://github.com/nextcloud/server.git'
  $docroot            = '/var/www/nextcloud'
  $www_user           = 'www-data'
  $www_group          = 'www-data'
  $ssl_dir            = '/etc/ssl/nextcloud'
  $ssl_cert_path      = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path       = "${ssl_dir}/nextcloud.key"
  $config_file        = "${docroot}/config/config.php"
  $permissions_script = "/var/www/nextcloud_permissions.sh"
  $php_ppa            = 'ppa:ondrej/php'
  $php_ppa_keys       = ['6A1AAD7AE5B401C6E259A7B257067BAA1314C7FC', '30B933D80FCE3D981A2D38FB0C99B70EF4FCBB07']
  $php_version        = '7.0'
}
