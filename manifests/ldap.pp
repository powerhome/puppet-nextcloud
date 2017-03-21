class nextcloud::ldap {
  exec { 'ldap_config_init':
    command => '/usr/bin/occ ldap:create-empty-config',
  }

  # Setup LDAP configuration
  $::nextcloud::ldap_config.each |$key, $value| {
    nextcloud_ldap_config { $key:
      ensure  => present,
      value   => $value,
      require => Exec['ldap_config_init'],
    }
  }
}
