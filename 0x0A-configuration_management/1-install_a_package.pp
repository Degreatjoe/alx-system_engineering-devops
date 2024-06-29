# This Puppet manifest installs Flask version 2.1.0 and Werkzeug version 2.1.1 using pip3
package { 'python3-pip':
  ensure => 'present',
}

exec { 'install_flask_and_werkzeug':
  command => '/usr/bin/pip3 install flask==2.1.0 werkzeug==2.1.1',
  path    => '/usr/bin/',
  unless  => '/usr/bin/pip3 show flask | grep -q "^Version: 2.1.0" && /usr/bin/pip3 show werkzeug | grep -q "^Version: 2.1.1"',
  require => Package['python3-pip'],
}
