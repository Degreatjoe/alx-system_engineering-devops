# This Puppet manifest configures the SSH client to use the private key ~/.ssh/school
# and refuse password authentication.

file { '.ssh/config':
  ensure  => 'file',
  owner   => 'degreatjoe',
  group   => 'degreatjoe',
  mode    => '0600',
  content => @("EOF")
    Host *
      IdentityFile .ssh/school
      PasswordAuthentication no
    | EOF
}
