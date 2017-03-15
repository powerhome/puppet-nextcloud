class nextcloud(
  $repo_tag  = $::nextcloud::params::repo_tag,
  $repo_url  = $::nextcloud::params::repo_url,
  $docroot   = $::nextcloud::params::docroot,
  $www_user  = $::nextcloud::params::www_user,
  $www_group = $::nextcloud::params::www_group,
) inherits nextcloud::params {

  class { 'apache':
    default_vhost => false,
  } ->
  class { 'nextcloud::install': } ->

}
