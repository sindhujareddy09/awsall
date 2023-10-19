#### Docker Commands:

```
To check images:
    $ docker images

To check container status:
    $ docker ps 

To check all container status:
    $ docker ps -a 

To run or start a container from image:
    $ docker run -d --name anyname -p 80:80 c3f279d17e0a

To login to container:
    $ docker exec -it container_id /bin/bash

To create Image from a container:
    $ docker commit c3f279d17e0a  kesavkummari/httpd123:1.3.0

To login to docker hub:
    $ docker login

    $ docker images

Tag the image and push it hub.docker.com :

    $ docker tag 78dcb7cc3f9f kesavkummari/httpd123:2.0.0
 
    $ docker images

    $ docker push kesavkummari/httpd123:2.0.0
```
