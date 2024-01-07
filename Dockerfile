# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Install necessary packages (httpd and PHP 8.0)
RUN yum -y install httpd php php-cli php-json

# Set the working directory
WORKDIR /var/www/html

# Create a simple PHP file for testing
RUN echo "<?php phpinfo(); ?>" > index.php

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
