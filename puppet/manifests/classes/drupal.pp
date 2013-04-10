class drupal {
  include workspace_mysql
  include workspace_apache_php

  package { imagemagick:
    ensure => installed,
  }

  # install drush, we use this method over the ubuntu package as that requires
  # a drush self-update that prompts for a version. This method uses drush's
  # official pear channel.
  package { 'pear.drush.org/drush':
      ensure => installed,
      provider => pear,
      require  => Exec['php::pear::auto_discover']
  }
}
