## dashing-zabbix

This setup will create a Dashing Ruby on Rails development environment with a sample zabbix dashboard and is based on [lynnaloo/dashing-vagrant](https://github.com/lynnaloo/dashing-vagrant) and [dav3860/zabbix_dashboard](https://github.com/dav3860/zabbix_dashboard).
 
It includes everything needed to set up a Centos 7 Virtualbox based Vagrant box that can connect to your own Zabbix server.

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

    vagrant $ cp jobs/zabbix.rb.sample jobs/zabbix.rb
    vagrant $ vi jobs/zabbix.rb

* Create /home/vagrant/dashing/jobs/zabbix.rb from jobs/zabbix.rb.sample 
* Change url, username and password to connect to zabbix. 
* You probably also want to change the hostgroups in this file to match those in your environment (you can find those by searching for "SCREENS" in this file).  


Start the Dashing server

    vagrant $ dashing start

### See the Sample Dashboard

Launch your local browser and navigate to application using localhost `http://localhost:3030`
or the static IP Address of the virtual machine `http://192.168.33.12:3030`
