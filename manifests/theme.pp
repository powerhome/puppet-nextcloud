class nextcloud::theme {

  # Theme name
  exec { 'nextcloud_theme_name':
    command => "/usr/bin/occ config:app:set theming name --value='${::nextcloud::theme_name}'",
    unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ config:app:get theming name | grep '${::nextcloud::theme_name}')\"",
  }

  # Theme slogan
  exec { 'nextcloud_theme_slogan':
    command => "/usr/bin/occ config:app:set theming slogan --value='${::nextcloud::theme_slogan}'",
    unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ config:app:get theming slogan | grep '${::nextcloud::theme_slogan}')\"",
  }

  # Theme URL
  exec { 'nextcloud_theme_url':
    command => "/usr/bin/occ config:app:set theming url --value='${::nextcloud::theme_url}'",
    unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ config:app:get theming url | grep '${::nextcloud::theme_url}')\"",
  }
}
