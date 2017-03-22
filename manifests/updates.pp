class nextcloud::updates {
  exec { 'nextcloud_update_channel':
    command => "/usr/bin/occ config:system:set updater.release.channel --value=${::nextcloud::update_channel}",
    unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ config:system:get updater.release.channel | grep '${::nextcloud::update_channel}')\"",
  }
}
