class nextcloud::apps {

  # External files
  exec { 'nextcloud_app_external_files':
    command => '/usr/bin/occ app:enable files_external',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ app:list | /bin/grep -E \'^.*-[ ]files_external:.*$\')"',
  }

  # User LDAP authentication
  exec { 'nextcloud_app_user_ldap':
    command => '/usr/bin/occ app:enable user_ldap',
    unless  => '/usr/bin/test ! -z "$(/usr/bin/occ app:list | /bin/grep -E \'^.*-[ ]user_ldap:.*$\')"',
  }
}
