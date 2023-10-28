#### Session Video :
    https://drive.google.com/file/d/1dAIycHwVkemEsXFsBzHwMILG6NN-Jj5p/view?usp=sharing
    
#### LCG - ASG - ALB


# Server-1:

#!/bin/bash

# Update Package Manager
sudo apt update
sudo apt-get install git curl wget unzip -y
sudo apt-get -y install binutils
cd /root/
git clone https://github.com/aws/efs-utils
cd /root/efs-utils
bash /root/efs-utils/build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

# To Install Web Server 
sudo apt install apache2 -y 

# Enable Webserver Deamon at Boot Level & Start the Service 
systemctl enable apache2
systemctl start apache2

# Deploy Simple Code 
# echo "<h1><center>Welcome To Cloud Binary - Learn By Doing - $(hostname -f)</center></h1>" > /var/www/html/index.html

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0e96bcbcf344da90b.efs.ap-south-1.amazonaws.com:/ /var/www/html/

