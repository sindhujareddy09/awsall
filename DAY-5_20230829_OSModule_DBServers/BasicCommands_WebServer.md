#### Session Video:
    https://drive.google.com/file/d/1I5Qgp1hPDkX0mWPu1_FQ_iX8y7O4d-h6/view?usp=sharing    

#### RDBMS

# RDBMS Databases

#### What is use of RDBMS Databases?
    A Relational Database Management System (RDBMS) is a type of database management system that stores data in a structured manner using tables, columns, and rows. Here are some of the common uses of RDBMS:

        1. Storing and Retrieving Data: RDBMS is used to store and retrieve data for various applications such as web applications, mobile applications, and desktop applications.

        2. Data Security: RDBMS provides data security by allowing access to only authorized users and preventing unauthorized access to the database.

        3. Data Integrity: RDBMS ensures the integrity of data by using various constraints such as primary keys, foreign keys, and check constraints.

        4. Data Consistency: RDBMS ensures that data is consistent by using transactions, which allow multiple updates to be processed as a single unit of work.

        5. Data Analysis: RDBMS provides powerful data analysis capabilities, such as aggregation, filtering, and sorting, which can be used for reporting and business intelligence.

        6. Scalability: RDBMS provides scalability by allowing the addition of more resources such as hardware and software, to handle growing amounts of data.

    Overall, RDBMS is a powerful and versatile tool that can be used for a wide range of applications that require efficient and secure data storage and retrieval, as well as sophisticated data analysis capabilities.

#### About MySQL DB :
    MySQL is a widely used relational database management system (RDBMS) that is used to manage and store data. Here are some of the common uses of MySQL:

        1. Web Applications: MySQL is often used in web applications to store and manage data, such as user data, content, and application settings.

        2. Content Management Systems (CMS): Many popular CMS platforms, such as WordPress and Drupal, use MySQL as their database system to store content, user data, and settings.

        3. Business Applications: MySQL can be used in a variety of business applications to manage and store data, such as financial data, customer data, and inventory.

        4. Analytics and Data Warehousing: MySQL can be used to store and manage large amounts of data for analytical purposes, such as data warehousing and business intelligence.

        5. Mobile and IoT Applications: MySQL can be used in mobile and IoT applications to store and manage data collected from sensors and other devices.

    MySQL is a robust and reliable database system that can handle large amounts of data and complex transactions. It is also open source and has a large community of developers, which means it is constantly being improved and updated with new features and enhancements.

#### List Of SQL & NoSQL Databases :

|SNo| RDBMS| NoSQL|
|-|------|------|
|1|MySQL	               | MongoDB|
|2|Oracle	               | Couchbase|
|3|Microsoft SQL Server | Cassandra|
|4|PostgreSQL	           | Redis|
|5|SQLite	                |Amazon DynamoDB|
|6|MariaDB	             |   Apache HBase|
|7|IBM DB2	             |   Apache CouchDB|
|8|Informix	            |Apache Cassandra|
|9|SAP Sybase ASE	        |Elasticsearch|
|10|Teradata	            |Neo4j|
|11|Microsoft Access	    |Riak|
|12|Amazon Aurora	        |Apache Kafka|
|13|Google Cloud SQL	    |Google Cloud Datastore|
|14|AWS RDS	            |    Azure Cosmos DB|


#### Use Case
    - Provision RDBMS :
        - MySQL 
        - Create a User 
        - Connect from Host Machine
        - Create Schema and Load some data:
            - Execute Create Schema, Create a Table, Insert dummmy Data to table, Update/Alter data in table, Query data in table
        - Validate & Hand-over the DB

#### RunBook:
    - STEP-1 : Go to AWS and Launch OS i.e. Windows or Linux
    - STEP-2 : Connect OS From Host Machine i.e. Laptop[Windows|MacOS]
    - STEP-3 : Validate RDBMS:
    - STEP-4 : Check Daemon/Service status:
    - STEP-5 : Validate Logs
    - STEP-6 : Validate your deployment :
    - STEP-7 : Hand-over the Database to Application Owner

#### Hands-On 
    - Go to OS i.e. Windows or Linux

#### Connect OS From Host Machine i.e. Laptop[Windows|MacOS]
        - Linux : SSH i.e. 

        - Windows : RDP i.e. 

#### Package Management - CentOS/Redhat/Fedora/Oracle Linux/AmazonLinux :
    $ yum list installed | grep mysql
    $ yum install mysql-community-server -y

#### Package Management - Debian/Ubuntu:
    $ dpkg -l | grep mysql
    $ apt update
    $ sudo apt install mysql-server -y 

#### Documentation :
    Path : /usr/share/man/man1/mysql.1.gz

#### Configuration :
    Path : /etc/my.cnf

#### Binary Files:
    Path : /usr/bin/mysql /usr/lib64/mysql

#### Log Files :
    Path : /var/log/mysqld.log
    $ sudo journalctl -u mysql

#### Service :
    Path : /usr/lib/systemd/system/mysqld.service

#### Enable, Stop, Start, Restart Service :

    To Enable a Service at boot level:
        $ systemctl enable mysqld
    
    To check a Service status:
        $ systemctl status mysqld

    To Start a Service:
        $ systemctl start mysqld

    To Restart a Service:
        $ systemctl restart mysqld    

    To Check Port:
        $ netstat -tulpn | grep LISTEN
        $ sudo ss -tap | grep mysql

    To Check a Service Port in Configuration File:
        $ cat /etc/services | grep -w '3306/tcp'

#### For Debian/Ubuntu:
    - You can edit the files in /etc/mysql/ to configure the basic settings – log file, port number, etc. For example, to configure MySQL to listen for connections from network hosts, in the file /etc/mysql/mysql.conf.d/mysqld.cnf, change the bind-address directive to the server’s IP address:
    - vi /etc/mysql/mysql.conf.d/mysqld.cnf
        bind-address            = 0.0.0.0

    $ sudo systemctl restart mysql.service

#### Find initial root password [CentOS/Redhat/Fedora/Oracle Linux/AmazonLinux]
    For root user Password is available in the log file:
    $ cat /var/log/mysqld.log

    To Grep root user Password from log file:
    $ cat /var/log/mysqld.log | grep "A Temporary password"

#### Connect MySQL Database from Linux Server:
    - Your MySQL server is ready to use now. 
    - From the terminal, you can run the below command to connect to the MySQL command line interface. 
    - It will prompt for the root account password. 
    - On successful authentication, you will get the MySQL prompt.

    $ mysql -u root -p 
