class workspace_apache_php {
	include workspace_mysql
	include apache
	include php

	class {'apache::mod::php':}
	apache::mod {'rewrite':}
	apache::mod {'vhost_alias': }

	user { "webdev-workspace":
		ensure => present,
		uid => '501',
		gid => 'dialout',
		shell => '/bin/sh',
		home => '/vagrant',
		managehome => false,
	}

	file { '/etc/apache2/conf.d/workspace':
		ensure => "present",
		content => "User webdev-workspace
Group dialout
Include \"/vagrant/conf.d/*.conf\"",
		require => A2mod['vhost_alias'],
		notify => Service[httpd]
	}

	package { php5:
		ensure => installed,
	}
	package { php5-mysql:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-gd:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-dev:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-curl:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-gmp:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-intl:
		ensure => installed,
		require => Package["php5"]
	}
	package { php-apc:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-cli:
		ensure => installed,
		require => Package["php5"]
	}
	package { php5-common:
		ensure => installed,
		require => Package["php5"]
	}
	package { php-pear:
	    ensure => installed,
        require => Package['php5']
	}


	# If no version number is supplied, the latest stable release will be
	# installed. In this case, upgrade PEAR to 1.9.2+ so it can use
	# pear.drush.org without complaint.
	package { 'PEAR':
	  ensure => present,
	  provider => pear
	}
	package { 'Console_Table':
	  ensure => present,
	  provider => pear
	}

	include xdebug

	file { '/etc/php5/conf.d/apc.ini':
		ensure => "present",
		content => "apc.shm_size=\"64M\"",
		require => Package['php-apc'],
	}

	file { '/etc/php5/conf.d/date.ini':
		ensure => "present",
		content => "[Date]
date.timezone = 'UTC'",
		require => Package['php5']
	}

	augeas { 'php_dev_config':
		context => '/files/etc/php5/apache2/php.ini/PHP',
		changes => [
			'set memory_limit 256M',
			'set max_execution_time 60',
			'set max_input_time 90',
			'set error_reporting E_ALL | E_STRICT',
			'set display_errors On',
			'set display_startup_errors On',
			'set html_errors On',
			'set error_prepend_string <pre>',
			'set error_apend_string </pre>',
			'set post_max_size 34M',
			'set upload_max_filesize 32M',
		],
		require => Package['php5'],
		notify => Service[httpd]
	}

  xdebug::config { 'default':
    remote_enable => '1',
    remote_handler => 'dbgp',
    remote_host => '172.16.232.1',
    remote_port => '9000',
  }
}
