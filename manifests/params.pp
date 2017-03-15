class nextcloud::params {
  $repo_tag      = 'v11.0.2'
  $repo_url      = 'git://github.com/powerhome/puppet-nextcloud.git'
  $docroot       = '/var/www/nextcloud'
  $www_user      = 'www-data'
  $www_group     = 'www-data'
  $ssl_dir       = '/etc/ssl/nextcloud'
  $ssl_cert_path = "${ssl_dir}/nextcloud.crt"
  $ssl_key_path  = "${ssl_dir}/nextcloud.key"
}
