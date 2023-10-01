#### Packer on Windows

STEP-1 : Go to Packer Website & Download Packer Software

    https://developer.hashicorp.com/packer/downloads

    https://releases.hashicorp.com/packer/1.8.6/packer_1.8.6_windows_amd64.zip
    
STEP-2 : Unzip the Packer Software

    cd Downloads/

    ls -lrt packer_1.8.6_windows_amd64.zip

    Unzip the file using 7zip 

    ls -lrt packer.exe
    
STEP-3 : Go to Windows C:/Program Files/

Create a folder : Packer 

STEP-4 : Copy packer.exe file from Download Folder to C:/Program Files/Packer/packer.exe

STEP-5 : Setup Environment Variables

User :

    path:  C:/Program Files/Packer/

System :

    path:  C:/Program Files/Packer/

STEP-6 : Close CMD, Powershell & VSCode And Restart Laptop/Desktop

STEP-7 : Verify Packer installation

    $ packer --version



#### Packer Linux 

``` Amazon Linux
sudo yum install -y yum-utils shadow-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

sudo yum -y install packer

```

``` Ubuntu
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install packer

```

``` CentOS or RHEL

sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

sudo yum -y install packer

```

#### MacOS

```
Download the Packer File

https://developer.hashicorp.com/packer/downloads

Unzip the Packer file

ck@ck ~ % ls -lrt ~/Downloads/packer

Last login: Sun Aug 20 19:51:27 on ttys000
ck@ck ~ % pwd
/Users/ck


ck@ck ~ % ls -lrt ~/Downloads/packer 

-rwxr-xr-x@ 1 ck  staff  93796816 Aug 18 23:50 /Users/ck/Downloads/packer


ck@ck ~ % sudo cp -pvr /Users/ck/Downloads/packer /usr/local/bin/

/Users/ck/Downloads/packer -> /usr/local/bin/packer

ck@ck ~ % packer --version

1.9.4

```