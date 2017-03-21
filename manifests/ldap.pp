class nextcloud::ldap {
  exec { 'ldap_config_init':
    command => '/usr/bin/occ ldap:create-empty-config',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ ldap:show-config)"',
  }

  # Setup LDAP configuration
  $::nextcloud::ldap_config.each |$config| {
    nextcloud_ldap_config { $config['key']:
      ensure  => present,
      value   => $config['value'],
      require => Exec['ldap_config_init'],
    }
  }
}
