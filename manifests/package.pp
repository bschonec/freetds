class freetds::package (
  $install = true,
  $ensure = 'installed',
) {
  if $install {
    case $::osfamily {
      'debian': {
        package {"freetds-bin": ensure => $ensure}
        package {"freetds-common": ensure => $ensure}
      }
      'redhat': {
        package {"freetds": ensure => $ensure}
      }
    }
  }
}
