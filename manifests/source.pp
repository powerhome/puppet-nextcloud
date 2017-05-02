class nextcloud::source {
  $install_file = "nextcloud-${::nextcloud::repo_version}.zip"
  $source       = "https://download.nextcloud.com/server/releases/${install_file}"
  $sha256sum    = 'd23095a517cbd547fb29bccde71e6d9faaa394b71fa89329f42cfa28b6aaffd3'

  # Download and install the specified version
  archive { $install_file:
    ensure        => present,
    name          => "/var/tmp/${install_file}",
    source        => $source,
    checksum      => $sha256sum,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => $::nextcloud::docroot,
    creates       => $::nextcloud::docroot,
  }
}
