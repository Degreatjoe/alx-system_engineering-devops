# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
    ensure => installed,
}

# Define a class to manage custom HTTP header configuration
class custom_http_response_header {
    
    # Define $hostname variable with the actual server's hostname
    $hostname = $facts['hostname']

    # Nginx configuration template inline
    file { '/etc/nginx/sites-available/default':
        ensure  => present,
        content => @(EOH)
            server {
                listen 80 default_server;
                listen [::]:80 default_server;
            
                server_name _;
            
                location / {
                    # Set X-Served-By header based on the server's hostname
                    add_header X-Served-By <%= $hostname %>;
                    
                    # Other configuration directives as needed
                    ...
                }
            
                # Additional server blocks or configurations as needed
            }
        EOH
        notify  => Service['nginx'],
    }
}

# Apply the class
include custom_http_response_header

# Enable and start Nginx service
service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
}
