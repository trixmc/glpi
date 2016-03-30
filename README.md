# ubuntu-14.04
Ubuntu with nginx, nano, mc, git, curl, screen, unzip, php5-fpm

#Create container (Ubuntu 14.04)
docker run -i -t -d -p 8111:80 -p 22:22 cristo/ubuntu-14.04 /bin/bash

#NGINX server config file for communicate with docker

```
server {
        listen *:80;
        server_name localhost;
        proxy_set_header Host localhost;
        client_max_body_size 100M;

                location / {
                                proxy_set_header Host $host;
                                proxy_set_header X-Real_IP $remote_addr;
                                proxy_cache off;
                                proxy_pass http://localhost:8111;
                        }
}
```

#SSH
ssh -p22 root@localhost
password: root

#Origin
[Docker Hub] (https://registry.hub.docker.com/u/cristo/ubuntu-14.04)

[Git Hub] (https://github.com/monte-fm/ubuntu-14.04)
