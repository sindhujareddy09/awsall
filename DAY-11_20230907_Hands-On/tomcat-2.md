#### Session Video:
    https://drive.google.com/file/d/1a1ZcUkulTsYHVlBatV633vNEAwjxPq_0/view?usp=sharing

# Hands-On:

Task-1 :
    1. Launch a EC2 Instance of Windows 2022 & attach IAM Role

    2. Download Tomcat

    3. Start Tomcat

    4. Validation

    5. Deploy a Artifact


STEP-1: 



#### Provision Linux i.e. Ubuntu:

```
# Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-02-08 | ami-0557a15b87f6559cf

$ aws ec2 run-instances \
--image-id "ami-0557a15b87f6559cf" \
--count 1 \
--instance-type t2.micro \
--key-name "us_east_1_keys" \
--security-group-ids "sg-09e7a75b97f33d7f1" \
--subnet-id "subnet-00a07bb8fefdfcfec" \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Tomcat},{Key=Environment,Value=dev}]'
```
#### Provision Linux i.e. CentOS/AmazonLinux2/Redhat:

```
# Amazon Linux 2 Kernel 5.10 AMI 2.0.20230221.0 x86_64 HVM gp2 | ami-006dcf34c09e50022

$ aws ec2 run-instances \
--image-id "ami-006dcf34c09e50022" \
--count 1 \
--instance-type t2.micro \
--key-name "us_east_1_keys" \
--security-group-ids "sg-09e7a75b97f33d7f1" \
--subnet-id "subnet-00a07bb8fefdfcfec" \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Tomcat},{Key=Environment,Value=dev}]'
```

#### Provision Windows:

```
# Microsoft Windows Server 2022 Full Locale English AMI provided by Amazon | ami-0c2b0d3fb02824d92

$ aws ec2 run-instances \
--image-id "ami-0c2b0d3fb02824d92" \
--count 1 \
--instance-type t2.micro \
--key-name "us_east_1_keys" \
--security-group-ids "sg-09e7a75b97f33d7f1" \
--subnet-id "subnet-00a07bb8fefdfcfec" \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Tomcat},{Key=Environment,Value=dev}]'
```

#### Download Install & Configure Documentation from Tomcat Official Website:

    Download Process: 
        
    Install Process:
        
    Configure Process:
        Windows: 

        Linux :

    Type Of Installation :
        Binary :

    STEP-1 : Go to Apache Tomcat :
        - Documentation
        - Downloads :
        - Hardware
        - Software : java
        - Process
    STEP-2 : Launch a Linux Machine

    STEP-3 : Utility Softwares : git curl wget unzip tree

    STEP-4 : Software : Java

    STEP-5 : Enable Tomcat Pages across Global

    STEP-6 : User, Password, Permissions

    STEP-7 : Access Tomcat & Deploy Java Application

#### Download, Install & Configure Tomcat on Linux Distributions:

    Here are the steps to download, install, and configure Tomcat on Linux Ubuntu using a shell script:

    1. Open a terminal window on your Ubuntu machine.

        Create a shell script file using the following command:

        $ vi tomcat-install.sh

    2. Paste the following code into the shell script file:

    ```
    # Debian/Ubutu
    #!/bin/bash

    # Setup Hostname
    sudo hostnamectl set-hostname "tomcat.cloudbinary.io"

    # Update the hostname part of Host File
    echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts

    # Update Ubuntu Repository
    sudo apt-get update

    # Download, & Install Utility Softwares
    sudo apt-get install git wget unzip curl tree -y

    # Download, Install Java 11
    sudo apt-get install openjdk-11-jdk -y

    # Backup the Environment File
    sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

    # Create Environment Variables
    echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

    # Go to /opt directory to download Apache Tomcat 
    cd /opt/

    # Download Apache Tomcat - Application
    sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz

    # Extract the Tomcat File
    sudo tar xvzf apache-tomcat-8.5.87.tar.gz

    # Rename the Tomcat Folder
    sudo mv apache-tomcat-8.5.87 tomcat

    # Go Inside the Tomcat Folder
    cd /opt/tomcat/

    # Take Tomcat Configuration as backup 
    sudo cp -pvr /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"

    # To delete last line and which contains </tomcat-users>
    sed -i '$d' /opt/tomcat/conf/tomcat-users.xml

    #Add User & Attach Roles to Tomcat 
    echo '<role rolename="manager-gui"/>'  >> /opt/tomcat/conf/tomcat-users.xml
    echo '<role rolename="manager-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
    echo '<role rolename="manager-jmx"/>'    >> /opt/tomcat/conf/tomcat-users.xml
    echo '<role rolename="manager-status"/>' >> /opt/tomcat/conf/tomcat-users.xml
    echo '<role rolename="admin-gui"/>'     >> /opt/tomcat/conf/tomcat-users.xml
    echo '<role rolename="admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
    echo '<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
    echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml

    # Start Tomcat Server
    cd /opt/tomcat/bin/

    ./startup.sh

    # Open a Browser and access tomcat : http://public_ip_of_ec2_instance:port(8080)

    ```

```
# vi /opt/tomcat/conf/tomcat-users.xml

<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<role rolename="admin-gui"/>
<role rolename="admin-script"/>

<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>

</tomcat-users>
```

#### vi /opt/tomcat/webapps/manager/META-INF/context.xml 

```
<?xml version="1.0" encoding="UTF-8"?>

<Context antiResourceLocking="false" privileged="true" >
</Context>
```


#### vi /opt/tomcat/webapps/manager/META-INF/context.xml 

    Open the context.xml file for the manager web application located in the $CATALINA_BASE/webapps/manager/META-INF directory. 
    
    Replace $CATALINA_BASE with the actual path of your Tomcat installation.

    Add the following lines within the <Context> element:

    vi /opt/tomcat/webapps/manager/META-INF/context.xml 

    ```
    <Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="[IP address of the remote machine]"/>

    ```

    - Replace [IP address of the remote machine] with the IP address of the remote machine that you want to grant access to. 
    - To grant access to all machines, use the following value for the allow attribute:


    ```
    allow="^.*$"
    ```    

    ```
    <!-- Example -->
    <Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="^.*$"/>

    ```

#### vi /opt/tomcat/webapps/host-manager/META-INF/context.xml 

```
<?xml version="1.0" encoding="UTF-8"?>

<Context antiResourceLocking="false" privileged="true" >
</Context>
```

#### vi /opt/tomcat/webapps/host-manager/META-INF/context.xml 

    Open the context.xml file for the manager web application located in the $CATALINA_BASE/webapps/manager/META-INF directory. 
    
    Replace $CATALINA_BASE with the actual path of your Tomcat installation.

    Add the following lines within the <Context> element:

    vi /opt/tomcat/webapps/host-manager/META-INF/context.xml 

    ```
    <Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="[IP address of the remote machine]"/>

    ```

    - Replace [IP address of the remote machine] with the IP address of the remote machine that you want to grant access to. 
    - To grant access to all machines, use the following value for the allow attribute:


    ```
    allow="^.*$"
    ```    

    ```
    <!-- Example -->
    <Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="^.*$"/>

#### Write init script vi /etc/systemd/system/tomcat.service 

```

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target 

[Service]
Type=forking
Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'service 

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=root 
Group=root
UMask=0007
RestartSec=10 
Restart=always

[Install]
WantedBy=multi-user.target

```


#### Write init script

```

sudo echo '[Unit]' > /etc/systemd/system/tomcat.service 
sudo echo 'Description=Apache Tomcat Web Application Container' >> /etc/systemd/system/tomcat.service 
sudo echo 'After=network.target' >> /etc/systemd/system/tomcat.service 

sudo echo '[Service]' >> /etc/systemd/system/tomcat.service 
sudo echo 'Type=forking' >> /etc/systemd/system/tomcat.service 

sudo echo 'Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid' >> /etc/systemd/system/tomcat.service  
sudo echo 'Environment=CATALINA_HOME=/opt/tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment=CATALINA_BASE=/opt/tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'' >> /etc/systemd/system/tomcat.service 

sudo echo 'ExecStart=/opt/tomcat/bin/startup.sh' >> /etc/systemd/system/tomcat.service 
sudo echo 'ExecStop=/opt/tomcat/bin/shutdown.sh' >> /etc/systemd/system/tomcat.service 

sudo echo 'User=root' >> /etc/systemd/system/tomcat.service 
sudo echo 'Group=root' >> /etc/systemd/system/tomcat.service 
sudo echo 'UMask=0007' >> /etc/systemd/system/tomcat.service 
sudo echo 'RestartSec=10' >> /etc/systemd/system/tomcat.service 
sudo echo 'Restart=always' >> /etc/systemd/system/tomcat.service 

sudo echo '[Install]' >> /etc/systemd/system/tomcat.service 
sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/tomcat.service 

```


```
#!/bin/bash

# Setup Hostname
sudo hostnamectl set-hostname "tomcat.cloudbinary.io"

# Update the hostname part of Host File
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts

# Update the Package Manager 
sudo apt-get update 

# Environment Variables
export TZ=Asia/Kolkata  

# Update Environment Variable unto File 
echo $TZ > /etc/timezone 

# Download, Install & Configure 
sudo apt-get update 
sudo apt-get install wget -y 
sudo apt-get install curl -y 
sudo apt-get install unzip -y 
sudo apt-get install openjdk-11-jdk -y 

# Environment Variables
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

# Update Environment Variable unto File 
#sudo echo $JAVA_HOME >> /etc/environment
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

# Cleanup APT Command 
sudo apt-get clean 

sudo mkdir /opt/tomcat/

WORKDIR /opt/

sudo curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.92/bin/apache-tomcat-8.5.92.tar.gz

sudo cd /opt/ && tar -xzf apache-tomcat-8.5.92.tar.gz && rm apache-tomcat-8.5.92.tar.gz

#sudo apache-tomcat-8.5.87.tar.gz /opt/tomcat/

sudo mv apache-tomcat-8.5.92/* /opt/tomcat/.

sudo ls -lrta /opt/tomcat/conf/tomcat-users.xml


# Take Tomcat Configuration as backup 
sudo cp -pvr /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"

# To delete last line and which contains </tomcat-users>
sudo sed -i '$d' /opt/tomcat/conf/tomcat-users.xml

#Add User & Attach Roles to Tomcat 
sudo echo '<role rolename="manager-gui"/>'  >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<role rolename="manager-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<role rolename="manager-jmx"/>'    >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<role rolename="manager-status"/>' >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<role rolename="admin-gui"/>'     >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<role rolename="admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
sudo echo '<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
sudo echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml

sudo echo '<?xml version="1.0" encoding="UTF-8"?>' > /opt/tomcat/webapps/manager/META-INF/context.xml 
sudo echo '<Context antiResourceLocking="false" privileged="true" >' >> /opt/tomcat/webapps/manager/META-INF/context.xml 
sudo echo '</Context>' >> /opt/tomcat/webapps/manager/META-INF/context.xml 

sudo echo '<?xml version="1.0" encoding="UTF-8"?>' > /opt/tomcat/webapps/host-manager/META-INF/context.xml 
sudo echo '<Context antiResourceLocking="false" privileged="true" >' >> /opt/tomcat/webapps/host-manager/META-INF/context.xml 
sudo echo '</Context>' >> /opt/tomcat/webapps/host-manager/META-INF/context.xml 

WORKDIR /opt/tomcat/webapps
sudo curl -O -L https://gitlab.com/kesav.kummari/ansible-role-tomcat/-/raw/main/tomcat/files/devops.war

#COPY ./devops.war /opt/tomcat/webapps/

sudo echo '[Unit]' > /etc/systemd/system/tomcat.service 
sudo echo 'Description=Apache Tomcat Web Application Container' >> /etc/systemd/system/tomcat.service 
sudo echo 'After=network.target' >> /etc/systemd/system/tomcat.service 

sudo echo '[Service]' >> /etc/systemd/system/tomcat.service 
sudo echo 'Type=forking' >> /etc/systemd/system/tomcat.service 

sudo echo 'Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid' >> /etc/systemd/system/tomcat.service  
sudo echo 'Environment=CATALINA_HOME=/opt/tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment=CATALINA_BASE=/opt/tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'' >> /etc/systemd/system/tomcat.service 

sudo echo 'ExecStart=/opt/tomcat/bin/startup.sh' >> /etc/systemd/system/tomcat.service 
sudo echo 'ExecStop=/opt/tomcat/bin/shutdown.sh' >> /etc/systemd/system/tomcat.service 

sudo echo 'User=root' >> /etc/systemd/system/tomcat.service 
sudo echo 'Group=root' >> /etc/systemd/system/tomcat.service 
sudo echo 'UMask=0007' >> /etc/systemd/system/tomcat.service 
sudo echo 'RestartSec=10' >> /etc/systemd/system/tomcat.service 
sudo echo 'Restart=always' >> /etc/systemd/system/tomcat.service 

sudo echo '[Install]' >> /etc/systemd/system/tomcat.service 
sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/tomcat.service 

sudo sed -i 's/port="8080"/port="80"/' /opt/tomcat/conf/server.xml

sudo systemctl enable tomcat.service

sudo systemctl restart tomcat.service

sudo systemctl status tomcat.service
```
