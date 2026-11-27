# Docker Firebird Server

## Version-specific documentation

| Firebird | Debian base | Architecture | Docker Hub status |
| --- | --- | --- | --- |
| [4.0.7](images/4.0.7/README.md) | 13 (Trixie) | `linux/amd64` | Pending publication |

For new versions, add a row and version-specific instructions. Mark a tag as published only after verifying it on Docker Hub.

## Example: run Firebird 4.0.7

From the repository root (Docker Compose v2.20 or later):

```sh
export SYSDBAPASS="$(openssl rand -hex 4)"
docker compose up --build -d
```

Compose builds `images/4.0.7`, stores databases in a named volume, and binds its ports to localhost for development. The root `Dockerfile` remains the legacy `3.0.12` build; use Compose or build the version directory explicitly for `4.0.7`.

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
