class nextcloud::ldap {
  exec { 'ldap_config_init':
    command => '/usr/bin/occ ldap:create-empty-config',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ ldap:show-config)"',
  }

  # Setup LDAP configuration
  $::nextcloud::ldap_config.each |$key, $value| {
    notify { "LDAP config: ${key} = ${value}": }
    nextcloud_ldap_config { $key:
      ensure => present,
      value  => $value,
    }
  }
}
