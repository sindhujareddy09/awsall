
#### JFrog Artifactory Integration With Jenkins

    - Login to Jenkins Server 
        % ssh -i <private_key.pem> user@public_ip 

    - Go to Jenkins User Home Directory 
        $ cd /var/lib/jenkins/

    - Go to .m2 directory part of Jenkins User Home Directory 
        $ cd .m2/

    - Create settings.xml file 
        $ touch settings.xml 

    - Add below configuration to settings.xml file 

##### settings.xml file [ Push Artifact To Snapshot & Release Folder ]

```
Note: To push artifact to libs-snapshots-local we need to update the pom.xml file with below code:

  - The way unique snapshots work is when the setting is set to UNIQUE and the repo layout is Maven (or Gradle) snapshots, and the file is deployed with a SNAPSHOT version according to the layout, Artifactory will rename it on the fly to contain Maven unique snapshot ID.

  - Maven publication will take care of the snapshot version, and Artifactory will take care of making those snapshots unique (and cleanups). You only need to make sure your version string ends with -SNAPSHOT.


    <artifactId>cb8am</artifactId>
    <version>1.0.1-SNAPSHOT</version>
    <packaging>war</packaging>
    <name>Cloud Binary Sample Spring MVC Application</name>
```

``` 
# Create settins.xml fille update with below content:


<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.2.0 http://maven.apache.org/xsd/settings-1.2.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <servers>
    <server>
      <username>admin</username>
      <password>Redhat@123</password>
      <id>release</id>
    </server>
    <server>
      <username>admin</username>
      <password>Redhat@123</password>
      <id>snapshots</id>
    </server>
  </servers>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
          <id>release</id>
          <name>libs-release-local</name>
          <url>http://44.204.189.57:8082/artifactory/libs-release-local/</url>
        </repository>
        <repository>
          <snapshots />
          <id>snapshots</id>
          <name>libs-snapshot-local</name>
          <url>http://44.204.189.57:8082/artifactory/libs-snapshot-local/</url>
        </repository>
      </repositories>
      <id>default</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>default</activeProfile>
  </activeProfiles>
</settings>
```

####  JFrog Artifactory Integration With VCS/SCM i.e. GitHub :

    - Login to GitHub

    - Go to Java Project Repository 

    - Go to POM.xml file

    - Add below configuration in pom.xml file 

```
<distributionManagement>
    <snapshotRepository>
        <id>snapshots</id>
        <name>libs-snapshot-local</name>
        <url>http://44.203.139.33:8082/artifactory/libs-snapshot-local/</url>
    </snapshotRepository>
    
    <repository>
        <id>release</id>
        <name>libs-release-local</name>
        <url>http://44.203.139.33:8082/artifactory/libs-release-local/</url>
    </repository>
</distributionManagement>

```

#### Go to Jenkins & Write job and execute 

  - mvn deploy 


#### To Encrypt Master Password for Jfrog

https://maven.apache.org/guides/mini/guide-encryption.html

```
cd /var/lib/jenkins/.m2/

vi settings-security.xml

<settingsSecurity>
  <master>{jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}</master>
</settingsSecurity>

mvn --encrypt-master-password Redhat@123

vi settings.xml

<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.2.0 http://maven.apache.org/xsd/settings-1.2.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <servers>
    <server>
      <username>admin</username>
      <password>{Mw8e3VApzUcHufxlN/TAnLLyMeVyyN+qhhXwLhin0ac=}</password>
      <id>release</id>
    </server>
    <server>
      <username>admin</username>
      <password>{Mw8e3VApzUcHufxlN/TAnLLyMeVyyN+qhhXwLhin0ac=}</password>
      <id>snapshots</id>
    </server>
  </servers>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
          <id>release</id>
          <name>libs-release-local</name>
          <url>http://54.152.32.116:8082/artifactory/libs-release-local/</url>
        </repository>
        <repository>
          <snapshots />
          <id>snapshots</id>
          <name>libs-snapshot-local</name>
          <url>http://54.152.32.116:8082/artifactory/libs-snapshot-local/</url>
        </repository>
      </repositories>
      <id>default</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>default</activeProfile>
  </activeProfiles>
</settings>

mvn --encrypt-password Redhat@123

```

#### Go to Jenkins & Write job and execute 

  - mvn deploy 