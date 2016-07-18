# tchmnkyz/freetds #

####Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
3. [Usage](#usage)
    * [Basic Usage](#basic-usage)
    * [Advanced Usage](#advanced-usage)
4. [Classes](#classes)

##Overview

FreeTDS uses a configuration file called freetds.conf (the name of the file can be controlled by an environment variable). Its format is similar to Samba's modified "win.ini" format. Its foremost job is to relate dataserver names, as known to your programs[1] , to machine names, as known your network. That is, while your machines have names known to the network, the dataservers on your machines have names known only to your FreeTDS client programs. The configuration file can then further describe that dataserver in greater detail, as need be. 

This module will install the packages required for this and maintain the freetds.conf file for you. 

## Setup


## Usage 

### Basic Usage
Basic usage making sure freetds is always the latest version and a simple host definition. 

```puppet
class {"freetds": ensure => 'latest',}

::freetds::conf {"db01.example.org":
	version => '4.2',
	host => 'db01.example.org',
	port => '1433',
}
```

### Advanced Usage

```puppet
class {"freetds":
	ensure => 'latest',
	version => '4.2'
}

::freetds::conf {"db01.example.org":
 version => '7.0',
 host => 'db01.example.org',
  port => '1433',
  nt_domain => 'example.org',
  connection_timeout => '15',
}
```

### Locales usage:

```puppet
class {"freetds":
 ensure => 'latest',
 version => '4.2'
}

::freetds::locales {"default":
  date_format => "%b %e %Y %I:%M:%S:%z%p"
}

::freetds::locales {"en_US":
  date_format => "%b %e %Y %I:%M:%S:%z%p",
  language => "us_english",
  charset => "iso_1",
}

::freetds::conf {"db01.example.org":
  version => '7.0',
  host => 'db01.example.org',
  port => '1433',
  nt_domain => 'example.org',
  connection_timeout => '15',
}
```

## Classes

* freetds
	* Parameters:
		* version
		* port
		* install
		* ensure
* freetds::package
	* Parameters:
		* install
		* ensure
* freetds::conf 
	* Parameters:
		* version
		* host
		* port
		* initial_block_size
		* try_server_login
		* try_domain_login
		* nt_domain
		* cross_domain_login
		* dump_file
		* dump_file_append
		* debug_level
		* timeout
		* connection_timeout
		* emulate_little_endian
		* client_charset
		* text_size
* freetds::locales
	* Parameters:
		* date_format
		* language
		* charset
