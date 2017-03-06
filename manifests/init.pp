class nextcloud(
  $repo_manage = $::nextcloud::params::repo_manage,
  $repo_url    = $::nextcloud::params::repo_url,
  $repo_key    = $::nextcloud::params::repo_key,
  $repo_key_id = $::nextcloud::params::repo_key_id,
) inherits nextcloud::params {

  class { 'nextcloud::repo': } ->

}
