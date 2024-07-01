# This Puppet manifest configures the SSH client to use the private key ~/.ssh/school
# and refuse password authentication.

$home = $facts['os']['family'] ? {
  'Darwin' => $facts['env']['HOME'],
  'default' => "/home/${facts['identity']['user']}"
}

file { "${home}/.ssh/config":
  ensure  => 'file',
  owner   => $facts['identity']['user'],
  group   => $facts['identity']['group'],
  mode    => '0600',
  content => @(EOF)
    Host *
      IdentityFile ${home}/.ssh/school
      PasswordAuthentication no
    | EOF
}
