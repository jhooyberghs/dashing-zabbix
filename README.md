## Dashing-Vagrant

[Vagrant](http://docs.vagrantup.com/v2/why-vagrant/index.html) is open-source software used to create lightweight
and portable virtual development environments. Vagrant works like a "wrapper" for VirtualBox that can create,
configure, and destroy virtual machines with the use of its own terminal commands. Vagrant facilitates the setup
of environments without any direct interaction with VirtualBox and allows developers to use preferred editors
and browsers in their native operating system.

This setup will create a Dashing Ruby on Rails development environment with a sample zabbix dashboard and is based on [lynnaloo/dashing-vagrant][https://github.com/lynnaloo/dashing-vagrant] and [dav3860/zabbix_dashboard][https://github.com/dav3860/zabbix_dashboard]

###  Install Vagrant ###

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Download and install [Vagrant](http://www.vagrantup.com/downloads.html)

### Install some usefull Vagrant plugins ###
- vagrant plugin install vagrant-vbguest
- vagrant plugin install vagrant-cachier

### Clone the repo ###

Clone this `dashing-vagrant` respository (or a fork) to a directory on your host machine:

    host $ git clone https://github.com/jhooyberghs/dashing-vagrant.git

### Connect to the Virtual Machine ###

Start the virtual machine:

    host $ vagrant up

Connect to the virtual machine via ssh:

    host $ vagrant ssh

Bundle the Ruby gems:

    vagrant $ cd dashing
    vagrant $ bundle install

Setup environment variables:

* Create /home/vagrant/dashing/jobs/zabbix.rb from jobs/zabbix.rb.sample (change url, username and password to connect to zabbix)
    vagrant $ cp jobs/zabbix.rb.sample jobs/zabbix.rb
    vagrant $ vi jobs/zabbix.rb

Start the Dashing server

    vagrant $ dashing start

### See the Sample Dashboard

Launch your local browser and navigate to application using localhost `http://localhost:3030`
or the static IP Address of the virtual machine `http://192.168.33.12:3030`
