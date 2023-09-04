#### Session Video:


#### Tomcat on Windows

#### Software Dependency 

    - Java 17

STEP-1 : Download, Install & Connfigure Java on Windows:
 
    https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

    .EXE File:
        https://download.oracle.com/java/17/archive/jdk-17.0.8_windows-x64_bin.exe

    .MSI File:
        https://download.oracle.com/java/17/archive/jdk-17.0.8_windows-x64_bin.msi    

STEP-2 : Setup Java Environment Variables :


    System : 

        JAVA_HOME=C:\Program Files\Java\jdk-17

    User :

        JAVA_HOME=C:\Program Files\Java\jdk-17

Calling or Accessing Environment Variables :

    echo %JAVA_HOME%


#### Tomcat Download and Install 

STEP-1 : Download Tomcat Artifact

    https://downloads.apache.org/tomcat/tomcat-10/v10.1.13/bin/apache-tomcat-10.1.13-windows-x64.zip


STEP-2 : Unzip with 7zip software 

    unzip a file apache-tomcat-10.1.13-windows-x64.zip

    cd ~/Downloads/

STEP-3 : Go inside the Tomcat Folder & Run executable file 

    cd C:/Users/Adminstrator/Downloads/

    startup.bat
