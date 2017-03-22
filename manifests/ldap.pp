class nextcloud::ldap {
  exec { 'ldap_config_init':
    command => '/usr/bin/occ ldap:create-empty-config',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ ldap:show-config)"',
  }

  # Setup LDAP configuration
  $::nextcloud::ldap_config.each |$key, $value| {
    exec { "ldap_config_${key}":
      command => "/usr/bin/occ ldap:set-config s01 ${key} ${value}",
      unless  => "/usr/bin/test ! -z \"$(/usr/bin/occ ldap:show-config s01 | /bin/grep -E '${key}[ ]' | /bin/grep -E '[ ]${value}[ ]')\"",
    }
  }
}
