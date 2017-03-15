class nextcloud(
  $ssl_cert,
  $ssl_key,
  $www_url,
  $repo_tag      = $::nextcloud::params::repo_tag,
  $repo_url      = $::nextcloud::params::repo_url,
  $docroot       = $::nextcloud::params::docroot,
  $www_user      = $::nextcloud::params::www_user,
  $www_group     = $::nextcloud::params::www_group,
  $ssl_dir       = $::nextcloud::params::ssl_dir,
  $ssl_cert_path = $::nextcloud::params::ssl_cert,
  $ssl_key_path  = $::nextcloud::params::ssl_key,
) inherits nextcloud::params {

  class { 'apache':
    default_vhost => false,
  } ->
  class { 'nextcloud::install': } ->

}
