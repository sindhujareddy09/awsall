#### Session Video:
    

#### Basic Commands and WebServer


#### Use Case : Hosting a Website

    - List of WebServers :
        To Hosting a Website, We need to use webservers: i.e. Apache httpd, Apache2, Nginx, IIS etc...
            
    - Host A Website on Linux Distributions :
        - Ubuntu / Amazon Linux 

    - Host A Website on Windows:
        - IIS  

#### What is Package Management?
        - Search a Package 
        - Install a Package
        - Update the package index
        - Upgrade packages
        - Remove a Package
        
    - Package management :
        # AmazonLinux / CentOS / Fedora / RHEL : 
            $ rpm 
            $ yum 
        # https://www.redhat.com/sysadmin/how-manage-packages

        # Debian / Ubuntu :
            $ dpkg
            $ apt       [For Interactive Terminal]
            $ apt-get   [For Scripts]

        # https://ubuntu.com/server/docs/package-management


#### Package Management
    - $ yum install httpd

#### Documentation :
    - Path : /usr/share/man/man1/httpd.1.gz

#### Configuration :
    - Path : /etc/httpd

#### Binary Files:
    - Path : /usr/sbin/httpd

#### DocumentRoot:
    - Path : /var/www/html/

#### Log Files :
    - Path : /var/log/httpd/

#### Controlling Services & Daemons : 
    
    - Service :
        Path : /usr/lib/systemd/system/httpd.service

    - To Enable a Service at boot level:
        $ systemctl enable httpd
    
    - To check a Service status:
        $ systemctl status httpd

    - To Start a Service:
        $ systemctl start httpd

    - To Restart a Service:
        $ systemctl restart httpd    

        $ netstat -tulpn | grep LISTEN

        $ cat /etc/services | grep -w '80/tcp'

    - Take Public Ip and Go to Browser and paste:

        http://23.22.33.211/
    