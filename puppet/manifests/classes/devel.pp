class devel {
	package { screen:
		ensure => installed,
	}
	package { mailutils:
		ensure => installed,
	}
	package { vim:
		ensure => installed,
	}
	package { git:
		ensure => installed,
	}
	package {
		php5-xdebug:
		ensure => installed,
		require => Package['php5']
	}

	# install xhprof. This requires beta install of xhprof.
	#package { 'xhprof':
	#    ensure => '0.9.2',
	#    provider => 'pecl'
	#}

	#file { '/etc/php5/apache2/conf.d/xhprof.ini':
	#	ensure  => 'present',
	#	content => 'extension=xhprof.so
#xhprof.output_dir=/var/tmp/xhprof',
	#	mode    =>  644,
	#	require => [
	#		Class['apache::mod::php'],
	#		Package['xhprof']
	#	]
	#}

}
