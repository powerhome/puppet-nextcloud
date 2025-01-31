class nextcloud(
  $ssl_cert,
  $ssl_key,
  $www_url,
  $admin_user,
  $admin_passwd,
  $datastore_bucket,
  $datastore_url,
  $datastore_key,
  $datastore_secret,
  $db_user,
  $db_name,
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
  $temp_directory,
  $mail_from,
  $mail_domain,
  $mail_host,
  $mail_port,
  $mail_pass,
  $redis_server,
  $redis_port,
  $apps,
  $php_timezone,
  $php_session_save_handler = $::nextcloud::params::php_session_save_handler,
  $php_session_save_path    = $::nextcloud::params::php_session_save_path,
  $repo_version             = $::nextcloud::params::repo_version,
  $repo_url                 = $::nextcloud::params::repo_url,
  $docroot                  = $::nextcloud::params::docroot,
  $www_user                 = $::nextcloud::params::www_user,
  $www_group                = $::nextcloud::params::www_group,
  $ssl_dir                  = $::nextcloud::params::ssl_dir,
  $ssl_cert_path            = $::nextcloud::params::ssl_cert_path,
  $ssl_key_path             = $::nextcloud::params::ssl_key_path,
  $config_file              = $::nextcloud::params::config_file,
) inherits nextcloud::params {

  apt::key { $::nextcloud::php_ppa_key: }
  apt::ppa { $::nextcloud::php_ppa:
    require => Apt::Key[$::nextcloud::php_ppa_key],
  }

  class { 'nextcloud::source': } ->
  class { 'nextcloud::apache': } ->
  class { 'nextcloud::php': } ->
  class { 'nextcloud::config': } ->
  class { 'nextcloud::install': } ->
  class { 'nextcloud::vhost': } ->
  class { 'nextcloud::cron': } ->
  class { 'nextcloud::apps': } ->
  class { 'nextcloud::ldap': } ->
  class { 'nextcloud::updates': } ->
  class { 'nextcloud::theme': }
}
