# Local SeedInvest Setup

This repo contains the core files to instatiate a containerized repository to run the SeedInvest stack locally

## Getting Started

### Prerequisites

Before you get started you will need to have installed [Docker](https://docs.docker.com/v17.09/engine/installation/) 

The desktop version for MacOS contains Docker Compose by default, if you are going rogue and installing a different way make sure to install [Compose](https://docs.docker.com/compose/install/) as well

Additionally you will need to ensure you have at least the following repos cloned *inside* of this directory

- [SI Services](https://github.com/seedinvest/seedinvest)
- [Web App](https://github.com/seedinvest/webapp)

Finally, you will need to ensure that you have a valid SSH key tied to your github account with proper access to pull SeedInvest repos

### Installing

To run the stack locally you will need to perform a couple steps

- Run `ssh-add` to ensure your SSH identity can be used by Docker to retrieve packages on build
- Build the required docker containers for SeedInvest and Web App
  - At the top level of the project run the following
    1 `export DOCKER_BUILDKIT=1`
    2 `docker build --ssh default -f web.Dockerfile -t si-web-app .`
    3 `docker build --ssh default -f si.Dockerfile -t si-services .`
- Next, ask someone nicely for an up to date SQL file to populate the database with
  - Make a directory called `.db_init` and place this file inside that directory
  
## Running the Stack

You should be all set!  In the top level directory, run `docker-compose up` and let it do its thing
