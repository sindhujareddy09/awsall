#### Session Video :
    https://drive.google.com/file/d/1ax1B3pbs1zxBsk-zeAStg9NUOQJrIRUy/view?usp=sharing
    
#### Load Balancers, CloudFront, S3 


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
4. Failover
5. Geolocation

ALB : Path Routinng 
NLB : 

```
<html>
<body  bgcolor="blue">

    <h1>Server-1 - Cloud Binary</h1>


</body>
</html>


<html>
<body  bgcolor="olive">

    <h1>Server-2 - Cloud Binary</h1>


</body>
</html>
```