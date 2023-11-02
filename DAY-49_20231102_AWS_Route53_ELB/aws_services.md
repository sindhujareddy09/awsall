#### Session Video :

    
#### Route53 & AWS Certificate Manager


```
# Server-1:

#!/bin/bash

# Update Package Manager
sudo apt update
sudo apt-get install git curl wget unzip -y

# To Install Web Server 
sudo apt install apache2 -y 

# Enable Webserver Deamon at Boot Level & Start the Service 
systemctl enable apache2
systemctl start apache2

# Deploy Simple Code 
# echo "<h1><center>WEB-1 Welcome To Cloud Binary - Learn By Doing - $(hostname -f)</center></h1>" > /var/www/html/index.html
```

https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html

1. Simple routing
2. Weighted routing
3. Latency-based routing

Pending :

4. Failover
5. Geolocation

ALB : Path Routinng 
NLB 