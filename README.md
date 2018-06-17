# Docker Firebird Server

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
Example
 -p 3051:3050
 
