!&# webdev workspace
====================

This is the web development environment used by [bangpound](http://bangpound.org) on a
Mac. It can probably work with few modifications on other environments.

Principles
----------

* Run servers on virtual machines.
* Avoid dependencies where possible in the host environment.
* Avoid editing configuration files at all.
* Prefer editing configuration files once instead of repeatedly.
* Be platform agnostic (so long as that platform is PHP).

Installation for Mac environments
---------------------------------

1. Install [homebrew](http://mxcl.github.com/homebrew/) and its dependencies.

2. Install [VMWare Fusion](http://www.vmware.com/products/fusion/overview.html) or
   [VirtualBox](https://www.virtualbox.org).

3. Install [Vagrant](http://www.vagrantup.com) and the
   [VMWare Fusion](http://www.vagrantup.com/vmware) if applicable.
4. Tap the PHP homebrew repository.

        brew tap josegonzalez/php

5. Use homebrew to install dnsmasq.

        brew install dnsmasq

6. Configure `dnsmasq`. This sets OpenDNS as the DNS server.

        cp /usr/local/opt/dnsmasq/dnsmasq.conf.example /usr/local/etc/dnsmasq.conf
        cat >> /usr/local/etc/dnsmasq.conf
        address=/.5/127.0.0.1
        address=/.6/127.0.0.1
        address=/.7/127.0.0.1
        address=/.8/127.0.0.1
        address=/.localhost/127.0.0.1
        address=/.symfony/127.0.0.1
        resolv-file=/etc/resolv.dnsmasq.conf
        ^D
        sudo cat > /etc/resolv.dnsmasq.conf
        nameserver 208.67.222.222
        nameserver 208.67.220.220
        ^D

7. Clone this repository in your home directory so that its path is `~/workspace`.

        cd ~
        git clone git@github.com:bangpound/webdev-workspace.git workspace

8. Also include MySQL client, PHP, Composer, drush. You'll probably need them.

        brew install mysql --client-only
        brew install drush
        brew install composer
        brew install php54 --without-apache

9. Run the Vagrant VM.

        vagrant up

10. Configure the local connections to MySQL.

        cat > /usr/local/etc/my.cnf
        [client]
        host=127.0.0.1
        port=3306
        password="vagrant"

11. Get to work.

        cd ~
        mysqladmin create drupal
        vagrant ssh
        cd /vagrant
        drush dl drupal-7.x drupal-7
        cd drupal-7/sites
        cp -R default my-new-site.7
        logout
        open http://my-new-site.7
