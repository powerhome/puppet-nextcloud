class nextcloud::params {

  $repo_version         = '12.0.2'
  $installed_version    = '12.0.2.0'
  $repo_url             = 'git://github.com/nextcloud/server.git'
  $www_user             = 'www-data'
  $www_group            = 'www-data'
  $ssl_dir              = '/etc/ssl/nextcloud'
  $ssl_cert_path        = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path         = "${ssl_dir}/nextcloud.key"
  $php_version          = '7.0'
  $php_ppa              = 'ppa:ondrej/php'
  $php_ppa_key          = '14AA40EC0831756756D7F66C4F4EA0AAE5267A6C'
  $apache_enabled_mods  = [
    'ssl',
    'headers',
    'rewrite',
  ]
}
