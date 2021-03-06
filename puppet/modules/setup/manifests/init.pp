# inspired by https://github.com/rails/rails-dev-box/blob/master/puppet/manifests/default.pp

class setup($ruby_version = "2.0") {

  $as_vagrant   = 'sudo -u vagrant -H bash -l -c'
  $home         = '/home/vagrant'

  Exec {
    path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }

  # --- Preinstall Stage ---------------------------------------------------------

  stage { 'preinstall':
    before => Stage['main']
  }

  class yum_update {
    exec { 'yum -y update':
      unless => "test -e ${home}/.rvm"
    }
  }
  class { 'yum_update':
    stage => preinstall
  }

  # --- Packages -----------------------------------------------------------------


  package { 'curl':
    ensure => installed
  }

  package { 'git':
    ensure => installed
  }

  package { ['ruby-devel', 'rubygems', 'rubygem-bundler', 'epel-release']:
    ensure => installed
  }

  # ExecJS runtime.
  package { 'nodejs':
    ensure  => installed,
    require => Package['epel-release'],
  }

  # --- Ruby ---------------------------------------------------------------------

  exec { 'install_gpg_rvm':
    command => "${as_vagrant} 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'",
    require => Package['curl'],
    timeout => '600',
  }

  exec { 'install_rvm':
    command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
    creates => "${home}/.rvm/bin/rvm",
    require => [ Package['curl'],Exec['install_gpg_rvm']],
    timeout => '600',
  }

  exec { 'install_ruby':
    # We run the rvm executable directly because the shell function assumes an
    # interactive environment, in particular to display messages or ask questions.
    # The rvm executable is more suitable for automated installs.

    command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-${ruby_version} --autolibs=enabled && rvm alias create default ${ruby_version}'",
    creates => "${home}/.rvm/bin/ruby",
    require => Exec['install_rvm']
  }

  # RVM installs a version of bundler, but for edge Rails we want the most recent one.
  exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
    creates => "${home}/.rvm/bin/bundle",
    require => Exec['install_ruby']
  }

  exec { 'ignore_warning' :
    command => "${as_vagrant} 'rvm rvmrc warning ignore ${home}/dashing/Gemfile'",
    require => Exec['install_rvm']
  }
}
