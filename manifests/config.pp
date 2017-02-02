define freetds::config (
  $host,
  $port,
  $version,
  $comment            = $title,
  $initial_block_size = undef,
  $try_config_login = undef,
  $try_domain_login = undef,
  $nt_domain = undef,
  $cross_domain_login  = undef,
  $dump_file = undef,
  $dump_file_append = undef,
  $debug_level = undef,
  $timeout = undef,
  $connection_timeout = undef,
  $emulate_little_endian = undef,
  $client_charset = undef,
  $text_size = undef,
) {
  include ::freetds::params

  if ! defined(Class['freetds']) {
    fail('Before you can use this resource, you must load the freetds base class!')
  }
  
    $valid_versions = "(4.2|5.0|7.0|7.1|7.2|8.0|auto)"
    validate_re($version, $valid_versions)


  # This section concatenates the instantiation of freetds::config and uses the individual
  # instance's $name variable (which is automatically assigned by puppet) as a distinguishing
  # feature so that we don't double-define.  Essentially this is a for/next loop.
  concat::fragment{"freetds_block_${name}":
    target => "${::freetds::path}/${::freetds::config}",
    content => template("${module_name}/freetds-host.conf.erb"),
    order   => 25,
  }
  
}
