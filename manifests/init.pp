class nextcloud(
  $ssl_cert,
  $ssl_key,
  $www_url,
  $admin_user,
  $admin_passwd,
  $db_user,
  $db_host,
  $db_pass,
  $instance_id,
  $instance_salt,
  $instance_secret,
  $ldap_config,
  $update_channel,
  $theme_name,
  $theme_slogan,
  $theme_url,
  $mail_from,
  $mail_domain,
  $mail_host,
  $mail_port,
  $mail_pass,
  $apps,
  $deploy_method    = 'traditional',
  $db_type          = 'mysql',
  $db_name          = undef,
  $redis_server     = undef,
  $redis_port       = 6379,
  $php_timezone     = 'America/New_York',
  $datastore_bucket = undef,
  $datastore_url    = undef,
  $datastore_key    = undef,
  $datastore_secret = undef,
  $service_name     = $::nextcloud::params::nextcloud_service,
  $repo_version     = $::nextcloud::params::repo_version,
  $repo_url         = $::nextcloud::params::repo_url,
  $www_user         = $::nextcloud::params::www_user,
  $www_group        = $::nextcloud::params::www_group,
  $ssl_dir          = $::nextcloud::params::ssl_dir,
  $ssl_cert_path    = $::nextcloud::params::ssl_cert_path,
  $ssl_key_path     = $::nextcloud::params::ssl_key_path,
) inherits nextcloud::params {

  case $deploy_method {
    default: {
      $docroot            = '/var/www/nextcloud'
      $base_dir           = '/var/www/nextcloud'
      $config_dir         = '/var/www/nextcloud/config'
      $config_file        = "${docroot}/config/extra.config.php"
      $permissions_script = '/var/www/nextcloud_permissions.sh'
      $install_script     = '/var/www/nextcloud_install.sh'
    }
    'docker': {
      $docroot            = '/var/www/html'
      $base_dir           = '/opt/nextcloud'
      $config_dir         = '/opt/nextcloud/config'
      $config_file        = '/opt/nextcloud/config/extra.config.php'
      $permissions_script = '/opt/nextcloud/nextcloud_permissions.sh'
      $install_script     = '/opt/nextcloud/nextcloud_install.sh'
    }
  }
  $data_dir = "${docroot}/data"

  class { 'nextcloud::service': }
  # class { 'nextcloud::cron': } ->
  # class { 'nextcloud::apps': } ->
  # class { 'nextcloud::ldap': } ->
  # class { 'nextcloud::theme': }
}
