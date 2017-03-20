class nextcloud::apache {

  # Install Apache
  class { 'apache':
    default_vhost => false,
    mpm_module    => 'prefork',
  }
}
