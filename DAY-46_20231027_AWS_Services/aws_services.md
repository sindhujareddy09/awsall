#### Session Video :


#### VPC 

    - Amazon Elastic Block Store (Amazon EBS):
        
        https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html

        https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html
    
    - Amazon Elastic File System (Amazon EFS)

    - Amazon S3

# Server-1:

#!/bin/bash

# Update Package Manager
sudo apt update

# To Install Web Server 
sudo apt install apache2 -y 

# Enable Webserver Deamon at Boot Level & Start the Service 
systemctl enable apache2
systemctl start apache2

# Deploy Simple Code 
echo "<h1><center>Welcome To Cloud Binary - Learn By Doing - $(hostname -f)</center></h1>" > /var/www/html/index.html

# Server-2:

#!/bin/bash

# Update Package Manager
sudo apt update

# To Install Web Server 
sudo apt install apache2 -y 

# Enable Webserver Deamon at Boot Level & Start the Service 
systemctl enable apache2
systemctl start apache2

# Deploy Simple Code 
echo "<h1><center>Welcome To Cloud Binary - Cloud & DevOps As Service - $(hostname -f)</center></h1>" > /var/www/html/index.html


sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0e96bjdjdjd4da90b.efs.ap-south-1.amazonaws.com:/ /var/www/html/

