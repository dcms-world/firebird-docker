# Docker Firebird Server

#### Firebirdserver Versions:

2.5.6, 2.5.7, 2.5.8, 2.5.9

3.0.0, 3.0.3, 3.0.4, 3.0.5, 3.0.6, 3.0.7, 3.0.8, 3.0.9, 3.0.10, 3.0.11, 3.0.12

4.0.0, 4.0.2, 4.0.3

## Example - run a Firebird 4.0.0 Server:

 docker run --rm -d -e SYSDBAPASS=somegoodpass -v /docker/firebird-docker/testdb:/db -p 3050:3050 --rm --name firebird4.0.2 dcms/firebird-docker:4.0.2

## Environment Variables
### SYSDBAPASS
Default password is "masterkey"
Example:
				
 -e "SYSDBAPASS=anotherpassword" 


## VOLUMES
## /db
To work with databases inside the container and store them permanent outside
Exmaple:

 -v db:/db
 
## PORTS
## 3050
Default Firebird Port inside the container is 3050, you can set it to another
Example:

 -p 3051:3050
 
## Docker-compose
There is a docker-compose.yml file where you can start more Firebirdservers on different Ports for developing


## WARNING 
### DO NOT USE THIS FOR PRODUCTION - ITS ONLY FOR DEVELOPMENT !!!
