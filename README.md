creates an icecast server in a docker container

osx local build:

```shell
boot2docker up  
eval $(boot2docker shellinit)  
docker run -it -p 8000:8000 xavierb/iceserv /bin/bash  
icecast -cb ../../../usr/local/etc/icecast.xml  
```