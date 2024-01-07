# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
#ARG PORT=8080

# Install necessary packages (httpd and PHP 8.0)
RUN yum -y install httpd php php-cli php-fpm

# Update the Apache configuration to use the specified port
#RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Set the working directory
WORKDIR /var/www/html

# Create a simple PHP file for testing
RUN echo "<?php phpinfo(); ?>" > index.php

# Copy your index.html file into the Apache document root
#COPY ./www.conf /etc/php-fpm.d/www.conf

# Expose port 80
ARG PORT=8080
EXPOSE 80 ${PORT}

RUN sed -i 's/LoadModule mpm_prefork_module/LoadModule mpm_event_module/' /etc/httpd/conf.modules.d/00-mpm.conf
RUN sed -i 's/#LoadModule proxy_module/LoadModule proxy_module/' /etc/httpd/conf/httpd.conf
RUN sed -i 's/#LoadModule proxy_fcgi_module/LoadModule proxy_fcgi_module/' /etc/httpd/conf/httpd.conf
RUN echo 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/var/www/html/$1' > /etc/httpd/conf.d/php-fpm.conf
#RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Start Apache in the foreground
CMD [""php-fpm", "--nodaemonize", "&", "httpd", "-D", "FOREGROUND""]
