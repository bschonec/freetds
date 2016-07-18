class freetds::params {

  $version = '8.0'
  $port = '1433'
  $install = true
  $ensure = installed
  
  case $::osfamily {
    
    'debian':   { $path = '/etc/freetds' }
    'redhat':   { $path = '/etc' }
    default:   { $path = '/etc' }
    
  }
  
  $config = 'freetds.conf'
  $locales = 'locales.conf'
  
  $path_mode = '0644'
  $path_owner = 'root'
  $path_group = 'root'
  
  $config_mode = '0644'
  $config_owner = 'root'
  $config_group = 'root'
  
}
