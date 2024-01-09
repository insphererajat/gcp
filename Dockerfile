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
#COPY ./html /var/www/html

# Copy your index.html file into the Apache document root
#COPY ./index.html /var/www/html/index.html

# Expose the port defined during build time
#EXPOSE $PORT

# The main command to start Apache when the container starts
#CMD ["httpd", "-D", "FOREGROUND"]


# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Install necessary tools
RUN dnf -y update \
    && dnf -y install curl unzip \
    && dnf clean all

# Install necessary packages (replace with your specific requirements)
RUN yum -y install java-11-openjdk-devel

# Download and extract Apache Tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.zip \
    && unzip apache-tomcat-9.0.84.zip -d /opt \
    && rm apache-tomcat-9.0.84.zip \
    && ln -s /opt/apache-tomcat-9.0.84 /opt/tomcat

# Define an argument for the port with a default value of 8080
ARG TOMCAT_PORT=8080

# Update Tomcat configuration to use the specified port
RUN sed -i "s/Connector port=\"8080\"/Connector port=\"$TOMCAT_PORT\"/" /etc/tomcat/server.xml

# Optionally, copy your custom configuration files or website content for Tomcat
COPY ./tomcat_conf/context.xml /etc/tomcat/context.xml
#COPY ./webapps /usr/share/tomcat/webapps

# Expose the ports defined during build time
EXPOSE $TOMCAT_PORT

# The main command to start services when the container starts
CMD ["sh", "-c", "/opt/tomcat/bin/catalina.sh run"]
