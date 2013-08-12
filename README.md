# Docker MySQL Demo

This Demo creates two mysql docker instances and sets up master<->master replication between them.

## Requirements

* Docker
* Internet

## Launch the Demo


```
$ source ./run_demo
```


## Output should look like

```
$ source ./run_demo
ID                  IMAGE                   COMMAND                CREATED                  STATUS                  PORTS
6b1545f0ac63        paulczar/mysql:latest   mysqld_safe --server   Less than a second ago   Up Less than a second                       
ee9ec17814fd        paulczar/mysql:latest   mysqld_safe --server   Less than a second ago   Up Less than a second                       
wait 2 seconds for mysql to start
Creating replication user...
Exporting Data from MySQL01 to MySQL02...
-- Warning: Skipping the data of table mysql.event. Specify the --events option explicitly.
Set MySQL01 as master on MySQL02...
Set MySQL02 as master on MySQL01...
Start Slave on both Servers...
Create database 'omgponies' on MySQL01...
Wait 2 seconds, then check that it exists on MySQL02...
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| omgponies          |
| performance_schema |
| test               |
+--------------------+
```

* The script will create some environment variables that you can use for further testing.   see contents of script.

# Authors

Paul Czarkowski - paul at paulcz dot net

# License

Copyright [2013] [Paul Czarkowski]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.