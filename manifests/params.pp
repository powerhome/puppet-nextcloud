class nextcloud::params {
  $repo_version         = '11.0.2'
  $installed_version    = '11.0.2.7'
  $repo_url             = 'git://github.com/nextcloud/server.git'
  $docroot              = '/var/www/nextcloud'
  $data_dir             = "${docroot}/data"
  $www_user             = 'www-data'
  $www_group            = 'www-data'
  $ssl_dir              = '/etc/ssl/nextcloud'
  $ssl_cert_path        = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path         = "${ssl_dir}/nextcloud.key"
  $config_file          = "${docroot}/config/config.php"
  $permissions_script   = "/var/www/nextcloud_permissions.sh"
  $install_script       = "/var/www/nextcloud_install.sh"
  $php_version          = '7.0'
  $php_ppa              = 'ppa:ondrej/php'
  $php_ppa_key          = '14AA40EC0831756756D7F66C4F4EA0AAE5267A6C'
  $apache_enabled_mods  = [
    'ssl',
    'headers',
    'rewrite',
  ]
}
