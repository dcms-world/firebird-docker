# Docker Firebird Server

## Version-specific documentation

| Firebird | Debian base | Architecture | Docker Hub status |
| --- | --- | --- | --- |
| [3.0.1](images/3.0.1/README.md) | 8 (Jessie) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=3.0.1) |
| [3.0.2](images/3.0.2/README.md) | 8 (Jessie) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=3.0.2) |
| [3.0.14](images/3.0.14/README.md) | 13 (Trixie) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=3.0.14) |
| [4.0.1](images/4.0.1/README.md) | 11 (Bullseye) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.1) |
| [4.0.4](images/4.0.4/README.md) | 12 (Bookworm) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.4) |
| [4.0.5](images/4.0.5/README.md) | 12 (Bookworm) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.5) |
| [4.0.6](images/4.0.6/README.md) | 12 (Bookworm) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.6) |
| [4.0.7](images/4.0.7/README.md) | 13 (Trixie) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.7) |
| [5.0.4](images/5.0.4/README.md) | 13 (Trixie) | `linux/amd64` | [Published](https://hub.docker.com/r/dcms/firebird-docker/tags?name=5.0.4) |

For new versions, add a row and version-specific instructions. Mark a tag as published only after verifying it on Docker Hub.

Version branches use the exact `X.Y.Z` branch name as the Docker image tag. A new version branch needs its own root `Dockerfile`, `compose.yml`, `startup.sh`, `smoke.sh` and `.github/workflows/version-branch-build.yml`. GitHub Actions checks the Dockerfile version, builds the branch image and verifies the running version over SQL. The branch build does not publish or overwrite Docker Hub tags.

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
