#### Session Video :
  https://drive.google.com/file/d/1-0ELgSpGTJ4-XNHOz9LljRnHStgB0PzS/view?usp=sharing
  
https://gitlab.com/kesav.kummari/ansible-role-tomcat

#### STEP-1 : Launch 2 EC2 Instance i.e. Ubuntu

```

AZ-1a

aws ec2 run-instances \
--image-id "ami-053b0d53c279acc90" \ 
--count 2 \
--instance-type t2.micro \
--key-name "ansible_nv" \
--security-group-ids "sg-07a189e920fd10fee" \
--subnet-id "subnet-0385704f22e343550" \
--iam-instance-profile Name=8amSSMEC2 \
--user-data file://ansible_install.txt \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=ansible-controller},{Key=Environment,Value=Development},{Key=ProjectName,Value=CloudBinary},{Key=ProjectID,Value=20221003},{Key=EmailID,Value=admin@cloudbinary.io},{Key=MobileNo,Value=+919100073006}]'

aws ec2 run-instances --image-id "ami-053b0d53c279acc90" --count 1 --instance-type t2.micro --key-name "ansible_nv" --security-group-ids "sg-07a189e920fd10fee" --subnet-id "subnet-0385704f22e343550" --iam-instance-profile Name=8amSSMEC2 --user-data file://ansible_install.txt --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=ansible-controller},{Key=Environment,Value=Development},{Key=ProjectName,Value=CloudBinary},{Key=ProjectID,Value=20221003},{Key=EmailID,Value=admin@cloudbinary.io},{Key=MobileNo,Value=+919100073006}]'

ansible_install.txt

# Install Ansible 

#!/bin/bash

# Setup New Hostname
hostnamectl set-hostname "ansible-controller.cloudbinary.io"

# Configure New Hostname as part of /etc/hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts

# Update the Repository
sudo apt update

# Download, Install & Configure Ansible
sudo apt install software-properties-common -y 

sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install ansible -y 

# Backup the Environment File
sudo cp -pvr /etc/ansible/hosts "/etc/ansible/hosts_$(date +%F_%R)"

# Create Environment Variables
echo "[web]" > /etc/ansible/hosts

echo "`aws ec2 describe-instances --instance-ids i-0f0f6b95a1298cc06 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text`" >> /etc/ansible/hosts

# aws ec2 describe-instances --instance-ids i-0f0f6b95a1298cc06 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text
# aws ec2 describe-instances --instance-ids i-0f0f6b95a1298cc06 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text

# To Restart SSM Agent on Ubuntu 
sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service

# Attach Instance profile To EC2 Instance 
# aws ec2 associate-iam-instance-profile --iam-instance-profile Name=SA-EC2-SSM --instance-id ""


AZ-1b

aws ec2 run-instances \
--image-id "ami-053b0d53c279acc90" \ 
--count 2 \
--instance-type t2.micro \
--key-name "ansible_nv" \
--security-group-ids "sg-07a189e920fd10fee" \
--subnet-id "subnet-0592ebfbf0bb99b29" \
--iam-instance-profile Name=8amSSMEC2 \
--user-data file://web-hostname.txt \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=web-node1},{Key=Environment,Value=Development},{Key=ProjectName,Value=CloudBinary},{Key=ProjectID,Value=20221003},{Key=EmailID,Value=admin@cloudbinary.io},{Key=MobileNo,Value=+919100073006}]'


aws ec2 run-instances --image-id "ami-053b0d53c279acc90" --count 1 --instance-type t2.micro --key-name "ansible_nv" --security-group-ids "sg-07a189e920fd10fee" --subnet-id "subnet-0592ebfbf0bb99b29" --iam-instance-profile Name=8amSSMEC2 --user-data file://web-hostname.txt --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=web-node1},{Key=Environment,Value=Development},{Key=ProjectName,Value=CloudBinary},{Key=ProjectID,Value=20221003},{Key=EmailID,Value=admin@cloudbinary.io},{Key=MobileNo,Value=+919100073006}]'

#!/bin/bash

# Setup New Hostname
hostnamectl set-hostname "web.cloudbinary.io"

# Configure New Hostname as part of /etc/hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts

# To Restart SSM Agent on Ubuntu 
# sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service

# Attach Instance profile To EC2 Instance 
# aws ec2 associate-iam-instance-profile --iam-instance-profile Name=SA-EC2-SSM --instance-id ""

```

# STEP-2: 

```
Generate SSH Keys part of Ansible Controller and Share with Nodes

STEP-2 : Create User i.e. automation & Add user to visudo or /etc/sudoers file:
        
$ Login to EC2 Instance of Redhat
        
$ sudo su
        
$ hostnamectl set-hostname "ansible-node1.cloudbinary.io"
        
$ echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts
        
$ adduser automation ---> use for ubuntu

$ useradd automation ---> other linux

$ passwd automation
  Redhat@123
  Redhat@123
            
$ vi /etc/sudoers
Add below content to sudoers file
  `
  %automation ALL=(ALL) NOPASSWD: ALL
  `

$ vi /etc/ssh/sshd_config
  `
  PasswordAuthentication yes
  `
- Restart SSH Service:
$ systemctl restart sshd

```

```
---
- name: Play-1 Setting Hostname 
  hosts: web  
  become: yes
  tasks:
    - name: Update the Ubuntu Repository
      apt: update_cache=yes
      ignore_errors: yes

    - name: Set Timezone 
      command: timedatectl set-timezone Asia/Kolkata
...

```


#### Example Playbooks

    Syntax Check:
        $ ansible-playbook --syntax-check web.yml


    Preview a Playbook:
        $ ansible-playbook --check web.yml


    Execute a Playbook:
        $ ansible-playbook web.yml

```
---
- name: Play-1 Configure NTP 
  hosts: web
  become: yes
  tasks:
    - name: Update Ubuntu Repository
      apt: update_cache=yes
      ignore_errors: yes
      
    - name: Install NTP Server
      apt: name=ntp state=present 

    - name: Enable and Start NTP Service 
      service: name=ntp state=restarted 
...

```

```
---
- name: Play-1  
  hosts: web 
  become: yes
  tasks:
    - name: Update the Ubuntu Repository
      apt: update_cache=yes
      ignore_errors: yes

    - name: Set Timezone 
      command: timedatectl set-timezone Asia/Kolkata

    - name: Install NTP Server
      apt: name=ntp state=present 

    - name: Enable and Start NTP Service 
      service: name=ntp state=restarted 

    - name: Web Server Apache2
      apt: name=apache2 state=present 

    - name: Enable & Start Apache2 Server 
      service: name=apache2 state=restarted 

    - lineinfile:
         path: /var/www/html/index.html 
         line: 'Welcome To Cloud Binary DevOps Team'
...
```


```
---
- name: Play-1 - MySQL
  hosts: web  # ---> /etc/ansible/hosts [web] publicip or hostname of the webserver
  become: yes
  tasks:
    - name: Update the Ubuntu Repository
      apt: update_cache=yes
      ignore_errors: yes

    - name: Set Timezone 
      command: timedatectl set-timezone Asia/Kolkata

    - name: Install NTP Server
      apt: name=ntp state=present 

    - name: Enable and Start NTP Service 
      service: name=ntp state=restarted 

    - name: MySQL DB Install 
      apt: name=mysql-server state=present 

    - name: Enable & Start MySQL Server 
      service: name=mysql.service state=restarted 

...
```

```
# Copy a File

- name: copy file from local host to remote host (absolute path)
  copy:
    src: /path/to/ansible/files/test_file
    dest: $HOME/test_file


# Backup a File in Remote Node:

# Coopy a File From Ansible Controller To Ansible Nodes
---
- name: Copy a File From Ansible Controller To Ansible Node-1
  hosts: app
  become: yes
  tasks:
  - name: Copy a File
    ansible.builtin.copy:
      src: /home/automation/dev.txt
      remote_src: true
      dest: /home/automation/dev.txt_20230324
      mode: '0644'
...

```


```
---
- name: Play-1 - Tomcat
  hosts: app  # ---> /etc/ansible/hosts [app] publicip or hostname of the tomcat
  become: yes
  tasks:
    - name: Update the Ubuntu Repository
      apt: update_cache=yes
      ignore_errors: yes

    - name: Set Timezone 
      command: timedatectl set-timezone Asia/Kolkata

    - name: Install NTP Server
      apt: name=ntp state=present 

    - name: Enable and Start NTP Service 
      service: name=ntp state=restarted 

    - name: Installating JDK.
      apt: name=default-jdk state=latest

    - name: Adding Group and user for Tomcat.
      shell: groupadd tomcat && useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
      
    - name: Installating curl.
      apt: name=curl state=latest

    - name: Downloading Apache Tomcat tar.
      shell: wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.75/bin/apache-tomcat-8.5.75.tar.gz    
      args:
        chdir: /tmp

    - name: Creating Apache Tomcat home directory.
      command: mkdir /opt/tomcat

    - name: Extracting Apache Tomcat.
      shell: tar -xzvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

    - name: Updating permission.
      command: "{{ item }}"
      with_items:
        - chown -R tomcat:tomcat /opt/tomcat
        - chmod -R g+r /opt/tomcat/conf
        - chmod g+x /opt/tomcat/conf

    - name: Creating service for Apache tomcat.
      file:
        path: /etc/systemd/system/tomcat.service
        state: touch
        mode: u+rwx,g-rwx,o-x

    - name: Upload a tomcat.service file unto /etc/systemd/system/
      get_url:
        src: ./tomcat.service
        dest: /etc/systemd/system/tomcat.service

    - name: Deamon reload.
      command: systemctl daemon-reload

    - name: Starting Apache Tomcat service.
      service: name=tomcat state=started

...
```

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
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

