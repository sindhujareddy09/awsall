#### Session Video:
    https://drive.google.com/file/d/1ygfMqgRxdruLOhEqtta5CszCzd6H2Xjl/view?usp=sharing
    
#### SQL 

#### To Create a User in MySQL DB:
    - Connect to MySQL as a root user
        - You need to connect to MySQL as a root user to create a new user and grant permissions. 
        - Open the MySQL shell and connect to the MySQL server as root user using the following command:
        ```
        mysql -u root -p

        ```
        - This will prompt you for the MySQL root user password.
        
#### Create a new user:
            - To create a new user in MySQL, use the CREATE USER statement. 
            - Replace newuser and password with your desired username and password respectively.
            ```
            CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
            CREATE USER 'tom'@'%' IDENTIFIED BY 'Redhat@123456';
            ```
            - This will create a new user called newuser with the password password and restrict login access to localhost.

#### Grant full permissions to the new user:
            - To grant full permissions to the new user, use the GRANT ALL PRIVILEGES statement. 
            - Replace newuser with the username you created in above step.
            ```
            GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'localhost';
            GRANT ALL PRIVILEGES ON *.* TO 'tom'@'%';
            ```
            - This will grant full permissions to the newuser user on all databases and tables. 
            - The *.* syntax specifies that the user should have full access to all databases and tables.

#### Reload privileges :
            - After granting permissions, you need to reload the privileges for the changes to take effect. 
            - You can do this by running the FLUSH PRIVILEGES statement.
            ```
            FLUSH PRIVILEGES;
            ```
            - That's it! You have now created a new user in MySQL and granted that user full permissions. 
            - The new user can now connect to the MySQL server and perform any operation on any database and table.

#### Creating a Schema:
        - A schema is a container that holds a set of tables, views, and other database objects. 
        - In MySQL, you can create a schema using the CREATE SCHEMA statement.
    
    ```
    CREATE SCHEMA my_schema;
    CREATE SCHEMA cloudbinary;
    ```
#### Creating a Table :
        - A table is a collection of related data stored in rows and columns. 
        - In MySQL, you can create a table using the CREATE TABLE statement. 
        - Here is an example of creating a users table with three columns: id, name, and email.
        
        ```
        CREATE TABLE my_schema.users (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(50) NOT NULL,
        PRIMARY KEY (id)
        );

        CREATE TABLE cloudbinary.students (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(50) NOT NULL,
        PRIMARY KEY (id)
        );

        ```
        - In this example, we created a table called users in the my_schema schema with three columns: id, name, and email. 
        - The id column is set as the primary key and will automatically increment with each new row inserted into the table.

#### Inserting Data into the Table :
        - Now that we have created a table, we can insert some data into it using the INSERT INTO statement.

        ```
        INSERT INTO my_schema.users (name, email) VALUES
        ('John Doe', 'john.doe@example.com'),
        ('Jane Smith', 'jane.smith@example.com'),
        ('Bob Johnson', 'bob.johnson@example.com');

        INSERT INTO cloudbinary.students (name, email) VALUES
        ('John Doe', 'john.doe@example.com'),
        ('Jane Smith', 'jane.smith@example.com'),
        ('Bob Johnson', 'bob.johnson@example.com');

        ```
        - In this example, we inserted three rows into the users table. 
        - Each row contains a name and an email value.

#### Updating Data in a MySQL Table :

        ```
        UPDATE my_schema.users SET name = 'John Smith' WHERE id = 1;
        ```

#### Querying Data from the Table :
        - Finally, we can query the data from the users table using the SELECT statement.

        ```
        SELECT * FROM my_schema.users;
        ```
        - This will return all rows from the users table. 
        - You can also specify specific columns to return using the following syntax:

        ```
        SELECT name, email FROM my_schema.users;
        ```
        - This will return only the name and email columns from the users table.

#### Connect MySQL DB From Host Maching using 3rd Party Tools:
    MySQL Workspace:
        https://dev.mysql.com/downloads/workbench/

    DBeaver:
    https://dbeaver.io/
        
#### Q?
    - 

####

```

root@ip-172-31-16-168:~#
root@ip-172-31-16-168:~# history
    1  cd
    2  su - ubuntu
    3  cd
    4  mysql
    5  init 0
    6  cd
    7  clear
    8  mysql
    9  runlevel
   10  systemctl status mysql
   11  clear
   12  cat /etc/os-release
   13  apt update
   14  apt install mysql-server -y
   15  cd
   16  mysql
   17  su - ubuntu
   18  CLEAR
   19  clear
   20  pwd
   21  whereis useradd
   22  whatis useradd
   23  whatis adduser
   24  whereis adduser
   25  adduser spider
   26  grep spider /etc/passwd /etc/shadow /etc/group /etc/gshadow
   27  chage -l spider
   28  chage spider
   29  chage -l spider
   30  su - ubuntu
   31  clear
   32  whatis userdel
   33  whereis userdel
   34  man userdel
   35  # userdel spider
   36  ls -lrt /home/spider/
   37  userdel spider
   38  ls -lrt /home/spider/
   39  userdel -r spider
   40  useradd hulk
   41  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
   42  passwd hulk
   43  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
   44  chage hulk
   45  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
   46  usermod -s /bin/bash hulk
   47  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
   48  usermod -d /opt/hulk hulk
   49  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
   50  usermod -c "DevOps Engineer" hulk
   51  grep hulk /etc/passwd /etc/shadow /etc/group /etc/gshadow
```