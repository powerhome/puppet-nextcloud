class nextcloud(
  $ssl_cert,
  $ssl_key,
  $www_url,
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
  $repo_tag      = $::nextcloud::params::repo_tag,
  $repo_url      = $::nextcloud::params::repo_url,
  $docroot       = $::nextcloud::params::docroot,
  $www_user      = $::nextcloud::params::www_user,
  $www_group     = $::nextcloud::params::www_group,
  $ssl_dir       = $::nextcloud::params::ssl_dir,
  $ssl_cert_path = $::nextcloud::params::ssl_cert,
  $ssl_key_path  = $::nextcloud::params::ssl_key,
  $config_file   = $::nextcloud::params::config_file,
) inherits nextcloud::params {

  class { 'apache':
    default_vhost => false,
  } ->
  class { 'nextcloud::install': } ->
  class { 'nextcloud::vhost': }
}
