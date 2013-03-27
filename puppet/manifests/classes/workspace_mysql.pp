class workspace_mysql {
	include mysql

    # Install mysql server with root password vagrant. Enable on all interfaces.
	class { 'mysql::server':
      config_hash => {
        'root_password' => 'vagrant',
        'bind_address' => '0.0.0.0'
      },
    }

	# Grant all privileges to root user on all interfaces.
    database_user { 'root@%':
      password_hash => mysql_password('vagrant')
    }
    database_grant { 'root@%':
      privileges => ['all'] ,
    }
}
