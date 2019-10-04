# Docker Firebird Server

#### Firebirdserver Versions:

2.5.6

2.5.7

2.5.8

2.5.9

3.0.0

3.0.3

3.0.4

4.0.0 Alpha

## Example - run a Firebird 3.0.3 Server:

 docker run -d -e SYSDBAPASS=somepass -v C:\GMS\firebird-docker\testdb:/db -p 3303:3050 --rm --name firebird3.0.3 dcms/firebird-docker:3.0.3

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
