# Class: freetds
#
# This module will install and manage freetds
#
# Parameters:
# 
# [*version*]
#   The TDS protocol version to use when connecting. Currently accepting: 4.2, 5.0, 7.0, 7.1, 7.2, 8.0, auto.
#   Default: 8.0
# 
# [*port*]
#   The port number that the dataconfig is listening to.
#   Default: 1433
#
# [*install*]
#   This will tell the module if it needs to install the freetds package or not. Values: True|False
#
# [*ensure*]
#   This tells the module to either what to do with the package it is installing. Values: installed|latest|absent
#
# [path]
#   This is the full path to the directory of the configuration file ([config]).  Optional.  Defaults to freetds::params::path.
#
# [config]
#   The file name of the freetds.conf file.  Optional.  Defaults to 'freetds.conf'.
#
# [path_mode]
#   The file permissions of the $path directory.
#
# [path_owner]
#   The ownership of the $path directory.
#
# [path_group]
#   The group ownership of the $path directory.
#
# Requires: see Modulefile
#
# Sample Usage:
#
# This will use the defaults for everything. 
#   class {"freetds": }
#
# To customize things you could do:
#   class {"freetds": version => "4.2", install = false, }
#

class freetds (
  $version = $::freetds::params::version,
  $port = $::freetds::params::port,
  $install = $::freetds::params::install,
  $ensure = $::freetds::params::ensure,
  $path = $::freetds::params::path,
  $config = $::freetds::params::config,

  $text_size = undef,
  $debug_flags = undef,
  $dump_file = undef,

  $path_mode  = $::freetds::params::path_mode,
  $path_group = $::freetds::params::path_group,
  $path_owner = $::freetds::params::path_owner,

) inherits ::freetds::params {

  if $install {
    class {'::freetds::package':
      ensure  => $ensure,
      install => $install,
    }
  }

  file { $::freetds::path:
    ensure => directory,
    owner  => $path_owner,
    group  => $path_group,
    mode   => $path_mode,
  }
  
  concat{"${::freetds::path}/${::freetds::config}":
    owner => root,
    group => root,
    mode  => '0644',
  }

  #concat::fragment{"freetds_header":
  #  target => "${::freetds::path}/${::freetds::config}",
  #  content => "### This file is managed by freetds puppet module. ###\n### Please do not make any Manual Changes! ###\n\n",
  #  order   => 01,
  #}
  
  concat::fragment{"freetds_global_${name}":
    target  => "${::freetds::path}/${::freetds::config}",
    content => template("${module_name}/freetds.conf.erb"),
    order   => 10,
  }

}
