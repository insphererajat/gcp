# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
ARG PORT=8080

# Install necessary packages (httpd and PHP 8.0)
RUN yum -y install httpd php php-cli

# Update the Apache configuration to use the specified port
RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Set the working directory
WORKDIR /var/www/html

# Create a simple PHP file for testing
RUN echo "<?php phpinfo(); ?>" > index.php

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
