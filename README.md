# CS 276 at LCC
Resources related to the Database Systems and Modeling course at Lane Community College

[Docker compose v2](https://docs.docker.com/compose/) must be installed to use this project

Requires Node / NPM be installed to use npm scripts. If using [NVM](https://github.com/nvm-sh/nvm), you can run `nvm use` to automatically use the correct version


# Running
This project uses Docker to host a MySql and a Microsoft SQL server, forwarding at the regular ports. The following commands are supported:
```sh
npm run docker:up   # Deploy the docker container
npm run docker:down # Delete the docker container and all volumes
```

A webapp is also included - [Adminer](https://www.adminer.org/) - in the docker container that can be used for easy administration of the hosted databases. It can be found by navigating to:

### http://localhost:8080

# Connecting
The databases can be connected to normally at localhost, since the regular ports are forwarded. To connect in Adminer, use the following settings:

## MySQL
| Input | Value |
|-------|-------|
| System | `MySQL` |
| Server | `mysql` |
| Username | `root` |
| Password | `averysecurepassword` |

## Microsoft SQL
| Input | Value |
|-------|-------|
| System | `MS SQL (beta)` |
| Server | `mssql` |
| Username | `sa` |
| Password | `aStrong(!)Password` |
