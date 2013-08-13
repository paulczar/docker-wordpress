# Docker Web Application Demo

This demo is a lightweight bash script to bring together several Docker Containers to create a tiered web application like you would deploy to Amazon.   

It is as simple as running `./run_demo` and takes about 5 seconds to build the whole stack,  4 seconds of which are are artificial sleeps to allow mysql to keep up.

An environment like this is perfect for testing major version changes, database schema changes, etc very quickly and easily during the development process.   

See the following Repos for the Docker buildfiles

* https://github.com/paulczar/docker-wordpress
* https://github.com/paulczar/docker-apache2
* https://github.com/paulczar/docker-haproxy
* https://github.com/paulczar/docker-mysql

```

                      | :80
                      |
                -------------- 
                |  HAProxy   |
                --------------
                   |      |
              :80 /        \ :80
                 /          \
       --------------     --------------  
       |  Apache/WP |     |  Apache/WP |   
       --------------     --------------
                 \           /
            :3306 \         / :3306
                -------------- 
                |  HAProxy   |
                --------------
                   |      |
            :3306 /        \ :3306
                 /          \
       --------------     --------------  
       |  MySQL01   |     |  MySQL02   |   
       --------------     --------------
              ^              ^
              |______________|

              Master <-> Master
                 Replication

```

## Requirements

* Docker
* Internet


## Launch the Demo

you may want to preload the docker containers

```
docker pull paulczar/mysql
docker pull paulczar/apache2-wordpress
docker pull paulczar/haproxy-mysql
docker pull paulczar/haproxy-web
```

`$ source ./run_demo`


## Output should look like

```
$ source ./run_demo                     

Create MySQL Tier
-----------------
* Create MySQL01
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
* Create MySQL02
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
* Sleep for two seconds for servers to come online...
* Creat replication user
* Export Data from MySQL01 to MySQL02
-- Warning: Skipping the data of table mysql.event. Specify the --events option explicitly.
* Set MySQL01 as master on MySQL02
* Set MySQL02 as master on MySQL01
* Start Slave on both Servers
* Create database 'wordpress' on MySQL01
* Sleep 2 seconds, then check that database 'wordpress' exists on MySQL02
wordpress

Create MySQL Load Balancer
--------------------------
* Create HAProxy-MySQL
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
* Check our haproxy works
   (should show alternating server_id)
server_id	1
server_id	2
server_id	1
server_id	2

Create Wordpress Web Servers
------------------------
* Create WordPress01
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
* Create WordPress02
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]

Create Web Load Balancer
--------------------------
* Create HAProxy-Web
WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
* Check it works
<tr><td class="e">PHP API </td><td class="v">20090626 </td></tr>
Environment Created!
--------------------

Browse to http://172.17.0.30 to access your wordpress site

Variables available fo you :-

MYSQL01_IP : 172.17.0.25
MYSQL02_IP : 172.17.0.26
HAPROXY_MYSQL_IP : 172.17.0.27
WORDPRESS1_IP : 172.17.0.28
WORDPRESS2_IP : 172.17.0.29
HAPROXY_WEB_IP : 172.17.0.30

```

# Authors

Paul Czarkowski - paul@paulcz.net

# License

Copyright 2013 Paul Czarkowski

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
