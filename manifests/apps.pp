class nextcloud::apps {
  $::nextcloud::apps.each |$app| {
    exec { "nextcloud_app_${app}":
      command => "/usr/bin/occ app:enable ${app}",
      unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ app:list | /bin/grep -E \'^.*-[ ]${app}:.*$\')\"",
    }
  }
}
