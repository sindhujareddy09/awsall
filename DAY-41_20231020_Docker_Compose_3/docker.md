#### Session Video :
https://drive.google.com/file/d/1QCk9ClLIHpQFg7X0hhfY7T4YP6vHFe-U/view?usp=sharing

```

#### Download, Install Docker on Ubutnu:
    https://docs.docker.com/engine/install/ubuntu/

    https://docs.docker.com/get-started/

    https://docs.docker.com/compose/


#### Hands-On Docker :

    - STEP-1 : Launch 1 EC2 Instances in AWS :

```
aws ec2 run-instances --image-id "ami-0557a15b87f6559cf" --count 1 --instance-type t2.medium --key-name "us_east_1_keys" --security-group-ids "sg-09e7a75b97f33d7f1" --subnet-id "subnet-00a07bb8fefdfcfec" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=docker-compose},{Key=Environment,Value=dev}]'

```

    - STEP-2 : Download, Install & Configure Docker on Ubuntu :

```
#!/bin/bash

# Setup Hostname 
hostnamectl set-hostname "docker.cloudbinary.io"

# Configure Hostname unto hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 

# Update the Ubuntu Local Repository with Online Repository 
sudo apt update 

# Download, Install & Configure Utility Softwares 
sudo apt install git curl unzip tree wget -y 

# Install Docker on Ubuntu Server
sudo apt-get install docker.io -y 

# Enable Docker For Ubuntu User
sudo usermod -aG docker ubuntu

# Grant Access Docker Socket
sudo chmod 777 /var/run/docker.sock

# Enable Docker Services at boot level
sudo systemctl enable docker

# Restart Docker Daemon 
sudo systemctl restart docker

```

#### Docker Commands:

```
    $ docker images

    $ docker ps 

    $ docker ps -a 

    $ docker run -d --name anyname -p 80:80 c3f279d17e0a

    $ docker exec -it container_id /bin/bash

    $ docker commit c3f279d17e0a  kesavkummari/httpd123:1.3.0

    $ docker login

    $ docker images

    $ docker tag 78dcb7cc3f9f kesavkummari/httpd123:2.0.0
 
    $ docker images

    $ docker push kesavkummari/httpd123:2.0.0
```

#### Dockerfile Examples

```

# Download Base Image from hub.docker.com
FROM ubuntu

# Execute Commands
RUN apt-get update 

# Environment Variables
ENV TZ=Asia/Kolkata   

# Update Environment Variable unto File 
RUN echo $TZ > /etc/timezone 

# Download, Install & Configure WebSever i.e. Apache - Apache2 
RUN apt-get install apache2 -y 

# Utils Package 
RUN apt-get install apache2-utils -y 

# Cleanup APT Command 
RUN apt-get clean 

# Enable WebServer Port i.e. HTTP 80/TCP
EXPOSE 80

# Execute WebServer
CMD ["apache2ctl","-D","FOREGROUND"]
```

#### Dockerfile Tomcat Example

```
# Download Base Image from hub.docker.com
FROM ubuntu

# Execute Commands
RUN apt-get update 

# Environment Variables
ENV TZ=Asia/Kolkata  

# Update Environment Variable unto File 
RUN echo $TZ > /etc/timezone 

# Download, Install & Configure 
RUN apt-get update 
RUN apt-get install openjdk-11-jdk -y 
RUN apt-get install wget -y 
RUN apt-get install curl -y 
RUN apt-get install unzip -y 

# Environment Variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

# Update Environment Variable unto File 
RUN echo $JAVA_HOME >> /etc/environment

# Cleanup APT Command 
RUN apt-get clean 

RUN mkdir /opt/tomcat/

WORKDIR /opt/
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz
RUN cd /opt/ && tar -xzf apache-tomcat-8.5.87.tar.gz && rm apache-tomcat-8.5.87.tar.gz
RUN pwd
#RUN apache-tomcat-8.5.87.tar.gz /opt/tomcat/
RUN mv apache-tomcat-8.5.87/* /opt/tomcat/.
RUN ls -lrta /opt/tomcat/conf/tomcat-users.xml


# Take Tomcat Configuration as backup 
RUN cp /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"

# To delete last line and which contains </tomcat-users>
RUN sed -i '$d' /opt/tomcat/conf/tomcat-users.xml

#Add User & Attach Roles to Tomcat 
RUN echo '<role rolename="manager-gui"/>'  >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<role rolename="manager-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<role rolename="manager-jmx"/>'    >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<role rolename="manager-status"/>' >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<role rolename="admin-gui"/>'     >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<role rolename="admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
RUN echo '<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
RUN echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml

RUN echo '<?xml version="1.0" encoding="UTF-8"?>' > /opt/tomcat/webapps/manager/META-INF/context.xml 
RUN echo '<Context antiResourceLocking="false" privileged="true" >' >> /opt/tomcat/webapps/manager/META-INF/context.xml 
RUN echo '</Context>' >> /opt/tomcat/webapps/manager/META-INF/context.xml 

RUN echo '<?xml version="1.0" encoding="UTF-8"?>' > /opt/tomcat/webapps/host-manager/META-INF/context.xml 
RUN echo '<Context antiResourceLocking="false" privileged="true" >' >> /opt/tomcat/webapps/host-manager/META-INF/context.xml 
RUN echo '</Context>' >> /opt/tomcat/webapps/host-manager/META-INF/context.xml 

WORKDIR /opt/tomcat/webapps
# RUN curl -O -L https://github.com/kesavkummari/devops/blob/master/target/devops-1.0.0-SNAPSHOT.war

COPY ./cloudops.war /opt/tomcat/webapps/

# Enable WebServer Port i.e. HTTP 80/TCP
EXPOSE 8080

# Execute WebServer
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

```
#### Docker Compose - Sample Python Project

https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/django/

```
#!/bin/bash

# Setup Hostname
hostnamectl set-hostname "docker-compose.cloudbinary.io"

# Configure Hostname unto hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 

# Update Ubuntu Operating System Repository
sudo apt-get update

# Download, Install & Configure Utility Softwares 
sudo apt-get install git curl unzip tree wget -y 

# Install Docker on Ubuntu Server
sudo apt-get install docker.io -y 

# Install Docker Compose on Ubuntu 
sudo apt-get install docker-compose -y 

# Enable Docker For Ubuntu User
sudo usermod -aG docker ubuntu

# Grant Access Docker Socket
sudo chmod 777 /var/run/docker.sock

# Enable Docker Services at boot level
sudo systemctl enable docker

# Restart Docker Daemon 
sudo systemctl restart docker

```