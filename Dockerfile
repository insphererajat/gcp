# Use the official Red Hat Universal Base Image (UBI) as the base image
#FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
#ARG PORT=8080

# Install necessary packages (replace with your specific requirements)
#RUN yum -y install httpd

# Update the Apache configuration to use the specified port
#RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Optionally, copy your custom configuration files or website content
#COPY ./vhosts.conf /etc/httpd/conf.d/vhosts.conf
# COPY ./html /var/www/html

# Copy your index.html file into the Apache document root
#COPY ./index.html /var/www/html/index.html

# Expose the port defined during build time
#EXPOSE $PORT

# The main command to start Apache when the container starts
#CMD ["httpd", "-D", "FOREGROUND"]

# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Install necessary packages (replace with your specific requirements)
RUN yum -y install java-11-openjdk-devel

# Install Tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz && \
    tar -xzvf apache-tomcat-9.0.50.tar.gz -C /opt && \
    rm apache-tomcat-9.0.50.tar.gz && \
    ln -s /opt/apache-tomcat-9.0.50 /opt/tomcat

# Install MariaDB
RUN yum -y install mariadb-server

# Define an argument for the port with a default value of 8080
ARG TOMCAT_PORT=8080
ARG MARIADB_PORT=3306

# Update Tomcat configuration to use the specified port
RUN sed -i "s/Connector port=\"8080\"/Connector port=\"$TOMCAT_PORT\"/" /etc/tomcat/server.xml

# Optionally, copy your custom configuration files or website content for Tomcat
COPY ./tomcat_conf/context.xml /etc/tomcat/context.xml
#COPY ./webapps /usr/share/tomcat/webapps

# Configure MariaDB
RUN systemctl enable mariadb
RUN systemctl start mariadb

# Copy your MariaDB custom configuration files
COPY ./mariadb_conf/my.cnf /etc/my.cnf.d/my.cnf

# Expose the ports defined during build time
EXPOSE $TOMCAT_PORT $MARIADB_PORT

# The main command to start services when the container starts
CMD ["sh", "-c", "/opt/tomcat/bin/catalina.sh run"]
