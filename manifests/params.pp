class nextcloud::params {
  $repo_version         = '11.0.2'
  $repo_url             = 'git://github.com/nextcloud/server.git'
  $docroot              = '/var/www/nextcloud'
  $www_user             = 'www-data'
  $www_group            = 'www-data'
  $ssl_dir              = '/etc/ssl/nextcloud'
  $ssl_cert_path        = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path         = "${ssl_dir}/nextcloud.key"
  $config_file          = "${docroot}/config/config.php"
  $permissions_script   = "/var/www/nextcloud_permissions.sh"
  $php_version          = '7.0'
  $php_ppa              = 'ppa:ondrej/php'
  $php_ppa_key          = '14AA40EC0831756756D7F66C4F4EA0AAE5267A6C'
  $apache_enabled_mods  = [
    'ssl',
    'headers',
    'rewrite',
    'access_compat',
    'auth_basic',
    'authn_core',
    'authn_file',
    'authz_groupfile',
    'authz_user',
    'autoindex',
    'cgi',
    'deflate',
    'dir',
    'env',
    'negotiation',
    'reqtimeout'
  ]
}
