# 2-puppet_custom_http_response_header.pp
# This manifest installs Nginx and configures a custom HTTP response header

# Ensure the Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Ensure the Nginx service is enabled and running
service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => File['/etc/nginx/sites-available/default'],
}

# Get the hostname of the server
$hostname = $facts['networking']['hostname']

# Configure Nginx to add the custom header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Template for Nginx configuration
file { '/etc/puppetlabs/code/environments/production/modules/nginx/templates/default.erb':
  ensure  => file,
  content => @("EOF"),
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # Custom header
    add_header X-Served-By <%= @hostname %>;
}
  | EOF
}
