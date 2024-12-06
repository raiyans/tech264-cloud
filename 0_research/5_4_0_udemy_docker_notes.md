# Docker complete guide


# Manipulating Containers with the Docker Client

# Whats Really a container?: How They Access the Kernel and Hardware

## 01 Overview of the Operating System
- **Kernel**: A software process that manages access between:
  - Programs (e.g., Chrome, Spotify, Node.js)
  - Physical hardware (e.g., hard drive, memory)
- **System Calls**: Function-like endpoints programs use to request hardware access (e.g., writing to a hard drive).

## The Concept of Namespacing
- **Namespacing**: Segments resources for specific processes, isolating them.
  - Example: Allocating different Python versions for Chrome (Python 2) and Node.js (Python 3).
  - The kernel routes system calls from processes to the correct resource segment.

## Control Groups (cgroups)
- Limit the resources a process can use:
  - CPU, Memory, Disk I/O, Network Bandwidth.

## Containers in Action
- A container = Process(es) + Isolated Resources
  - The kernel mediates all system calls.
  - Resource isolation includes hard drive, memory, CPU, etc.

![container](/images/docker-kernal-diagram.png)
## Relation to Image
- **Image**: A filesystem snapshot + startup command.
  - When launched:
    1. Kernel isolates a resource segment.
    2. Filesystem snapshot is copied into the segment.
    3. Startup command initializes the container process.

![container](/images/docker-running-on-pc.png)

## How Docker Runs on macOS and Windows
- **Linux-Specific Features**:
  - Namespacing and control groups are only available in Linux kernels.
- **Docker Desktop Solution**:
  - Installs a **Linux Virtual Machine (VM)** on non-Linux systems.
  - Containers are hosted inside the Linux VM, leveraging the Linux kernel.
- **Linux Kernel Role**:
  - Handles resource isolation (namespacing) and usage limits (cgroups).

## Verifying the Linux VM
- Run `docker version` in the terminal:
  - The **Server OS** entry will display `Linux`, confirming a Linux VM is being used.

## Key Takeaways
- Docker Desktop relies on a Linux VM to enable container functionality on Windows and macOS.
- The Linux kernel inside the VM manages the isolation and allocation of hardware resources for containers.

![container](/images/dk-dockerdesktop-on-vm.png)

# commands

## 001. Docker Run in Detail

![create-and-run-container-1.png](/images/create-and-run-container-1.png)

eg:
```
docker run hello-world
```

## Overriding Default Commands

![container](/images/overriding-default-command-1.png)
e.g
``` bash
docker run busybox echo hello world!
```
## 004. Container Lifecycle
- docker run vs docker start = run shows logs automatically, start needs -a flag

![container](/images/dk-container-lifecycle-1.html)
![container](/images/dk-container-lifecycle-2.html)
``` bash
→ docker create hello-world
9271d26374ff54f715ce137ab71b5d86a7e9af3638b51d0a470fd8765c55821e
→ docker start -a 9271d26374ff54f715ce137ab71b5d86a7e9af3638b51d0
```

## 005. Restarting Stopped Container

eg:
``` bash
docker start -a 4b263884282
```

## 006. Removing Stopped Containers
- help remove disk space when you not working with docker long time
eg:
``` bash
docker system prune
```

## 007. Retrieving log Outputs

eg:
``` bash
docker log 4b263884282
docker log <container_id>
```

## 008. Stopping Containers

- stop command use to take more time for shutdown the container.
- after 10 secs grace period docker stop  will default to docker kill in background
  
- kill command use to shutdown the container immediately.

``` bash
# Example: docker stop
# Gracefully stops a container by sending a SIGTERM signal and allows cleanup.

docker stop <container_name_or_id>

# Example:
docker stop my_container

# Example: docker kill
# Immediately terminates a container by sending a SIGKILL signal without cleanup.

docker kill <container_name_or_id>

# Example:
docker kill my_container
```
## 009. Multi-command Containers

we have two separate containers. we want to include redis-cli container into
redis-server container to run together

![multi-command-containers.gif](/images/multi-command-containers.gif)

## 010. Executing Command in Running Containers

![executing-command-in-running-containers-1.png](/images/executing-command-in-running-containers-1.png)

eg:
``` bash
docker exec -it 4b263884282 redis-cli
```

## 011. The Purpose of the IT flag

When you running docker on your computer or machine every single container you
are running is running inside a virtual machine running Linux.

![the-purpose-of-the-it-flag.gif](/images/the-purpose-of-the-it-flag.gif)

The IT flag is two separate flag

```
-it

# or

-i -t

 -i, --interactive          Keep STDIN open even if not attached
 -t, --tty                  Allocate a pseudo-TTY | make sure all the text nicely format | auto-complete
```

## 012. Getting a Command Prompt in a Container

You will not want to execute without having execute same command.

"sh" is a command processor or a shell its allow to type command in and will be
execute inside the container.

![getting-a-command-prompt-in-a-container-1.png](/images/getting-a-command-prompt-in-a-container-1.png)

eg:
```
docker exec -it 4b263884282 sh
docker exec -it <img id> sh
```

## 013. Starting with a Shell

![starting-with-a-shell.gif](/images/starting-with-a-shell.gif)

## 014. Container Isolation

The containers do not automatically share their files system

![container-isolation.gif](/images/container-isolation.gif)

# **Building Custom Images** Through Docker Server

## 015. Creating Docker Images

![creating-docker-images.gif](/images/creating-docker-images.gif)

## 016. Building a Dockerfile

``` bash
docker build --progress=plain 

to see build info check notes page before about buildkit
```
``` dockerfile
# Use an existing docker image as base
FROM alpine
#Downlad and install a dependency
RUN apk add --update redis
RUN apk add --update gcc
# Tell the image what to do when i starts as a container
CMD ["redis-server"]

```

## 017. Dockerfile Teardown
- FROM,RUN,CMD explanations

![dockerfile-teardown.png](/images/dockerfile-teardown-cmds.png)
![dockerfile-teardown.png](/images/dockerfile-teardown.png)

## 018. What's a Base Image

![what-a-base-img-1.png](/images/what-a-base-img-1.png)

![what-a-base-img-2.png](/images/what-a-base-img-2.png)

## 019. The Build Process in Details

why use new command?
```
docker build .
```

the build command it's will be use to take docker file and generating it

![the-build-process-in-detail-1.png](/images/the-build-process-in-detail-1.png)

![the-build-process-in-detail.gif](/images/the-build-process-in-detail.gif)

## 020. A Brief Recap

![a-brief-recap.gif](/images/a-brief-recap.gif)

## 021. Rebuild with Cache
- rebuild have cache to make it faster for installing dependencies
- cache not activated if the linear order of same commands changed. 
- it will use cache if new lines are added below existing cached orders not reordered ones.
- just make sure you should add commands below existing ones and not in-between existing ones
![rebuild-with-cache.gif](/images/rebuild-with-cache.gif)
![rebuild-with-cache.gif](/images/rebuild-cache-terminal)

## 022. Tagging an Image

![tagging-an-image-1.png](/images/tagging-an-image-1.png)

the convention to tagging an Image

![tagging-an-image-2.png](/images/tagging-an-image-2.png)

eg:
```
docker build -t localhost/redis:latest .

# and run

docker run localhost/redis
```

## 023. Manual Image Generation with Docker Commit

In common, we use image to create container. We can manually create a container
runs command inside container and generate an image. In straight word we can do
manually the same thing Dockerfile does.

![manual-image-generate-with-docker-commit.gif](/images/manual-image-generate-with-docker-commit.gif)

eg:
```
# IMPORTANT YOU DON'T WANT USE THIS WAY IN GENERAL
# BETTER USE Dockerfile APPROACH

docker commit -c 'CMD["redis-server"]' 4b263884282
```

# == Making Real Projects with Docker ==

## 024. Making Real Projects with Docker

[simple-web](./simple-web/)

## 025. Base Image Issues

![base-image-issues-1.png](/images/base-image-issues-1.png)

To solve the issue "npm not available on a base image"

~~~
#Dockerfile
FROM node: alpine
~~~

alpine is a term in docker role for a small incompact images. Many popular
repository were going to offer alpine version of their images.

## 027 A few Missing Files

None of the files inside your root directory are available inside the container by
default. Completely segmented out unless you specifically allowed inside your
Dockerfile.

- package.json not available to use inside docker container we're trying to create 

![few-missing-files-1.png](/images/few-missing-files-1.png)

To solve 'no such file or directory'

![copying-build-files-1.png](/images/copying-build-files-1.png)

- COPY command will fix issue of accessing files for containers. take diagram for path directions
  
eg:
~~~
#Dockerfile
# Install some dependencies

COPY ./ ./

#Default command
.....
~~~

## 028. Container Port Mapping

![container-port-mapping-1.png](/images/container-port-mapping-1.png)

We do not setup port-porting inside Dockerfile, a port-porting stuff is strictly
a run time constrain, in other words its something we only change when we run
a container or start a container.

- no restrictions for docker container to reach out to internet. restrictions for allowing connections coming into docker container

![container-port-mapping-2.png](/images/container-port-mapping-2.png)

- if you wanna change internal port number then you have to make sure its changed within the app example node app, api server, etc.

eg:
~~~
docker run -p 8080:8080 localhost/simpleweb
~~~

## 029. Specifying a Working Directory

- you can put your working directory in usr other conventions are home and var folders 

![specifying-a-working-directory-1.png](/images/specifying-a-working-directory-1.png)

eg:
~~~
# Dockerfile

WORKDIR /usr/app
~~~

- Workdir will make us open in the /usr/app folder and also make commands run in the same folder we chose in workdir
- to check the working directory is no longer in image root directory we can check by

eg:

~~~
#open 1st cli
docker run -p 5001:5001 <initial-name>/<initial-docker-container>

#open 2nd cli to check
docker exec -it <id-container> sh
~~~

## 030. Unnecessary Rebuilds
- how to avoid having completely reinstall all dependencies just because we made
a change in source code file?
- Make a change to the order and let working directory take package.json first to have npm install be cached. 
- the copy code files over to work dir to make code changes keeping more cache
eg:
~~~
#Dockerfile

COPY ./package.json ./    #just copying current specify directory to WORKDIR directory
RUN npm install           # just run once

COPY ./ ./                # copy over everything else except package.json
~~~

# Docker Compose with Multiple Local Containers

## 031. Introducing Docker Compose

- docker compose vs docker cli manual set up for networking
![introducing-docker-compose-1.png](/images/introducing-docker-compose-1.png)

## 032. Docker Compose Files

``` bash

docker build -t stephengrider/visits:latest
docker run -p 8080:8080 stephengrider/visits
# equivalent into docker compose
```

![docker-compose-files-1.png](/images/docker-compose-files-1.png)

- docker-compose file divided into code blocks for understanding
![docker-compose-files-2.png](/images/docker-compose-files-2.png)

``` dockerfile
# Use Alpine Linux as the base image
FROM alpine

# Install Redis
RUN apk add --update redis

# Install GCC (optional, depending on the requirements)
RUN apk add --update gcc

# Command to run Redis server
CMD ["redis-server"]

```

## 033. Networking with Docker

- how does the web app know where the url to the other container is? redis-server example how docker-compose gives it the missing ip


![networking-with-docker-compose-1.png](/images/networking-with-docker-compose-1.png)

1. When the Node.js app (web app) tries to connect to "redis-server", Docker intercepts the request.
2. Docker uses an internal DNS service to resolve "redis-server" to the container's IP address within the network.
3. The Redis container listens on its default port 6379 for incoming connections from the web app.

**Why No Manual IP is Needed?**
- Containers can communicate by referencing service names.
- IPs are dynamically assigned but managed internally by Docker.
``` yaml
#docker-compose.yml
services:
  redis-server:     # 1st image
    image: 'redis'
  node-app:         # 2nd image
    ...
    ...
    ...
```
``` javascript
## app.js
const client = redis.createClient({
  // add docker images
  host: 'redis-server',
  // default redis-server
  port: 6379                # specify port for redis-server
});
```

## 034. Docker Compose Command

- docker compose up vs docker compose up --build
## `docker-compose up`
- **Purpose**: Starts all containers and services defined in the `docker-compose.yml` file.
- **Key Features**:
  - Automatically creates a shared **network** for all services.
  - Launches containers based on existing images.
  - Resolves hostnames to service names for inter-container communication.
## `docker-compose up --build`
- **Purpose**: Rebuilds the images for services before starting containers.
- **Key Features**:
  - Ensures the latest changes in the Dockerfile or context directory are reflected in the image.
  - Useful after modifying source code, dependencies, or the Dockerfile.
Example:
``` bash
docker-compose up --build
# Rebuilds images before starting the containers.
```


![docker-compose-commands-1.png](/images/docker-compose-commands-1.png)

## 035. Stopping Docker Compose Containers

- docker compose down to spin down all containers in 1 go

![stopping-docker-compose-containers-1.png](/images/stopping-docker-compose-containers-1.png)

## 036. Container Maintenance with Compose

![automatic-container-restarts-1.png](/images/automatic-restarts-docker)
- docker compose status code 0=ok,  1,2,3=something went wrong

![automatic-container-restarts-1.png](/images/automatic-container-restarts-1.png)

- different restart policies you can choose like always and on failure
~~~
#docker-compose.yml

version: '3'
services:
  redis-server:
    image: 'redis'
  node-app:
    restart: always       # Restart Policies
    build: .
    ports:
      - "5001:5001"
~~~

## 037. Container Status with Docker Compose
- docker-compose ps 
eg:
~~~
#in cli with folder related docker-compose.yml
docker-compose ps
~~~

# Creating a Production-Grade Workflow

## 038. Development Workflow

![development-workflow-1.png](/images/development-workflow-1.png)

## 039 flow Specifics

![flow-specifics-1.png](/images/flow-specifics-1.png)


## 040. Docker Purpose

![docker-purpose-1.png](/images/docker-purpose-1.png)


## 041. Creating the Dev Dockerfile
- docker.dev file for runninng only dev environment dockerfile
- take note of `copy . .` and the order for efficiency 
eg:
``` bash
#create Dockerfile.dev in root folder directory

#run in cli
docker build -f Dockerfile.dev -t "<images-name>/<container-name>:latest" .    
# -f is stand for looking a specify Dockerfile
```

## 042. Duplicating Dependencies

![duplicating-dependencies-1.png](/images/duplicating-dependencies-1.png)

to solve this problem, just delete __node_modules__ on root folder.

```
.
├── node_modules    # Delete this for avoid duplicate files in images
├── public
└── src
```

- deleting the folder node_modules the same as adding a .dockerignore file and adding node_modules

## 043. Docker Volumes
![docker-volumes-1.png](/images/docker-volumes-1.png)

- dokcer volume to reference local files instead of copy . . explanation here to document
  
### Docker Volumes to Reference Local Files

Why Use Docker Volumes?
- **Default Behavior**:
  - During image building, files (e.g., `src`, `public`) are **copied** into the container.
  - This creates a snapshot of the files at that moment, which remains static and won't reflect local changes.
- **Solution**: Use **Docker volumes** to map local directories to directories inside the container.
  - This enables real-time updates to local files to be reflected in the container without rebuilding the image.
## How Docker Volumes Work
- **Volumes** establish a **mapping**:
  - A folder on your local machine ↔ A folder inside the container.
- Changes to files in the mapped local folder are instantly available in the container.

## Syntax for Docker Volumes
``` bash
docker run -p 3000:3000 -v $(pwd):/app <image_id>
```

### Explanation:
1. **`-p 3000:3000`**:
   - Maps port `3000` on the container to port `3000` on the host.
2. **`-v $(pwd):/app`**:
   - `-v`: Creates a volume. | Bind mount a volume
   - `$(pwd)`: Refers to the **present working directory** (current folder on your machine).
   - `:/app`: Maps the local folder (`pwd`) to the `/app` folder inside the container.
  
![overriding-dockerfile-selection.gif](/images/docker-local-reference-not-found.png)

### Explanation of Additional Volume
- **`-v /app/node_modules`**:
  - Marks the `node_modules` folder inside the container to avoid overwriting it with the local directory.

---

## Common Issue: React Scripts Not Found
- If you encounter errors like `React Scripts not found`:
  - The `node_modules` directory in the container might be overwritten by the local volume.
  - Use the `-v /app/node_modules` volume to isolate `node_modules`.


## 044. Shorthand with Docker Compose

![overriding-dockerfile-selection.gif](/images/overriding-dockerfile-selection.gif)

- docker command of volumes can be translated into a docker compose file for easy use

### Docker Run Command Example
``` bash
docker run -p 3000:3000 -v $(pwd):/app -v /app/node_modules <image_id>
```

### Equivalent `docker-compose.yml`
``` yaml
version: "3.8"

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
```

---

## Explanation
### `build` Options
- **`context`**: Specifies the directory containing the files and folders for the build.
  - Example: `.` refers to the current directory.
  - If the files are in a subdirectory, replace `.` with the relative path, e.g., `./my-react-app`.
- **`dockerfile`**: Specifies the name of the Dockerfile to use.
  - Example: `Dockerfile.dev` refers to a custom development Dockerfile.

### `volumes`
- **`.:/app`**: Maps the current directory on the host machine to `/app` in the container.
- **`/app/node_modules`**: Prevents overwriting the container's `node_modules` directory with the host's directory.

### `ports`
- **`3000:3000`**: Maps port `3000` on the host to port `3000` in the container.

---

- You could delete `COPY . .` line for for the docker.dev file
## Why Can You Remove `COPY . .`?
- **Volume Mounting**:
  - With Docker Compose, local files are mapped into the container using volumes (e.g., `.:/app`).
  - The container references local files dynamically, so there's no need to copy source code into the container.

- **Effect**:
  - Removing the `COPY . .` line avoids duplicating files into the container's `/app` directory, as the volume provides real-time access to the local files.

---

## Updated `Dockerfile.dev`
Here’s what the modified `Dockerfile.dev` might look like:
~~~
FROM node:14

WORKDIR /app

COPY package.json .
RUN npm install

CMD ["npm", "start"]
~~~

---

## 045. Live Updating Tests

- over rider CMD with your own command like npm run test
- running overide command to run tests makes its own container that doesnt let it access the test files through volumes
~~~
# open 1st cli
docker-compose up   # to build an image

# open 2nd cli
docker ps   # to copy the run CONTAINER-ID

docker exec -it <container-id> npm run test
~~~

## 046. Docker Compose for Running Tests
- overide command in docker compose for running tests
``` yaml
# docker-compose.yml
# add this code
version "3"
  services:
  ....
  ....
  ....
  # for test purpose
  test:
    build:
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - /app/node_modules
      - .:/app
    # override command to run test
    command: ["npm", "run", "test"]
```
``` bash
# run cli
docker-compose up --build
```
- diagram of 2 containers using docker compose and how input commands effect it
![multi-step-docker-builds-1.png](/images/container-testing-shortcomings.png)
- docker attach will always run on the npm process 1 stdin and not the the one running the tests which is a coppied process but with arguements
![multi-step-docker-builds-1.png](/images/container-test-shortcomings-attach.png)
  
## 046. Need for Nginx
- nginx is a lightweight production server we can use  in this case
- `npm run build` for prod version as opposed to `npm run start`

## 047. Multi-Step Docker Build for Production environment

- multi images for 1 container wizardry :o
- called multi-step build process

![multi-step-docker-builds-1.png](/images/multi-step-docker-builds-1.png)

but we have an issue here,

![multi-step-docker-builds-2.png](/images/multi-step-docker-builds-2.png)

so we make two different images to solve this issue.

![multi-step-docker-builds.gif](/images/multi-step-docker-builds.gif)

## 048. Implementing Mutli-Step build
``` dockerfile
# Production Environment

# Specify a base image
FROM node:alpine as builder

WORKDIR '/app'

# install some dependencies
COPY package*.json ./
RUN npm install

COPY . .

# Default command | build phase
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

```

- `FROM node:alpine as builder` the key word as builder seperates the containers to build the image you want!
- `COPY --from=builder /app/build /usr/share/nginx/html` lets you access previous image

## 049. Running Nginx

### NGINX as a Web Server
- **Purpose**: NGINX serves static files, such as the React application built using `npm run build`.
- **Configuration**: The `Dockerfile` is set up to copy the build files into NGINX’s default directory.

### Build the Image:
~~~
docker build -t my-react-app .
~~~

### Run the Container:
~~~
docker run -p 8080:80 my-react-app
~~~

![running-Nginx-1.png](/images/running-Nginx-1.png)

# Continuous Integration and Deployment with AWS 

## 050. Travis CI Setup

![travis-ci-setup-1.png](/images/travis-ci-setup-1.png)

### What is Travis CI?

**Travis CI** is a hosted, distributed continuous integration service used to
build and test projects hosted at Github. **Travis CI** automatically detects
when a commit has been made and push to a Github repository that is using
**Travis CI**, and each time this happen, it will try to build project and run
test.

## 051. Travis YML file Configuration

![travis-yml-file-config-1.png](/images/travis-yml-file-config-1.png)

[.travis.yml file](./frontend/.travis.yml)

~~~
#.travis.yml

script :
  - docker build -e CI=true -t <images-name>/<container-name>:<env> npm run test -- --coverage

# added a options
-- --coverage   # to make automatically run command exit

-e CI=true      # it tells docker the env list
~~~

## 052. AWS Elastic Beanstalk

![elastic-beanstalk-1.png](/images/elastic-beanstalk-1.png)

The benefit of using **Elastic Beanstalk** is monitors the amount of the traffic
that come into our virtual machines and automatically scale everything up.

## 053. Travis Config for Deployment

![travis-config-for-deployment-1.png](/images/travis-config-for-deployment-1.png)

for bucket_name:

![travis-config-for-deployment-2.png](/images/travis-config-for-deployment-2.png)
eg:
~~~
# add this into .travis.yml

deploy:
  provider: elasticbeanstalk
  region: "us-west-2"                                             # the region you choose
  app: "docker"                                                   # a name that you setup in aws
  env: "Docker-env"                                               # a name that revere as the environment
  bucket_name: "elasticbeanstalk-us-west-2-<your-app-id>"
  bucket_path: "docker"                                           # the name same as app names
  on:
    branch: master
~~~

## 054. Automated Deployments

Set an API_KEYS to give access to our aws account over Travis-CI.

![automated-deployments-1.gif](/images/automated-deployments-1.gif)

At travis CI add your access_key_id and secret_access_id,

![automated-deployments-2.gif](/images/automated-deployments-2.gif)
~~~
# add this into .travis.yml

deploy:
  provider: elasticbeanstalk
  region: "us-west-2"                                             # the region you choose
  app: "docker"                                                   # a name that you setup in aws
  env: "Docker-env"                                               # a name that revere as the environment
  bucket_name: "elasticbeanstalk-us-west-2-<your-app-id>"
  bucket_path: "docker"                                           # the name same as app names
  on:
    branch: master
  # a new line setting
  access_key_id: $AWS_ACCESS_KEY
  secret_access_key:
    secure: "$AWS_SECRET_KEY"                                     # make sure you put double quote
~~~

## 055. Exposing Ports Through the Dockerfile | for production-env deployment

![exposing-ports-through-the-dockerfile-1.gif](/images/exposing-ports-through-the-dockerfile-1.gif)
~~~
# at Dockerfile | production-env

EXPOSE 80   # is a communication for each developers
~~~

if you hit an error when deploy to aws, maybe you forget to config EXPOSE at Dockerfile

![exposing-ports-through-the-dockerfile-2.gif](/images/exposing-ports-through-the-dockerfile-2.gif)

At *aws-elascticbeanstalk* is little bit different , *elasticbeanstalk* when it's
start up docker container is gonna look at **Dockerfile** and gonna look to
**EXPOSE** instruction, and what ever port you listed in there, is what
*elasticbeanstalk* is going to map directly automatically.

## DONT FORGET TO TERMINATE the ELastic Beanstalk app! for AWS not charge some money

# == Building a Multi Container Application ==

## 056. Single Container Deployment Issues

![single-container-deployment-issues-1.png](/images/single-container-deployment-issues-1.png)

### THIS IS A BAD APPROACH
We build the images multiple times, we build out our images over **travis-CI**
when we run our task, and we also build image a second time after we push all
over code through **travis-CI** over to **Elastic Beanstalk**. This is not the
best approach because we essentially taking web-server or web-apps and we using
it to build the images, chance are we really want the web-server to be just
**concern running the web-server** and not to take any extra process of building
images. So we concern to not allow the images to build in active running
web-server.

## 057. Application Overview

![multi-container-application-overview-1.gif](/images/multi-container-application-overview-1.gif)

## 058. Application Architecture | Backend Architecture

![multi-container-application-architecture-1.png](/images/multi-container-application-architecture-1.png)

![multi-container-application-architecture-2.png](/images/multi-container-application-architecture-2.png)
~~~
Nginx               # to do some routing
React Server        # get some front-end mockup | assets
Express Server      # to set backend API
Worker              # a separate backend NodeJS process
Redis               # a memory data-store for housing temporary value
Postgres            # a database which is very similar with mysql
~~~

### a flow behind the scene

![multi-container-application-architecture-3.png](/images/multi-container-application-architecture-3.png)

# == Dockerizing Multiple Service ==

## 059. Dockerizing a React App - Again!

![dockerizing-a-react-app-again-1.png](/images/dockerizing-a-react-app-again-1.png)

The purpose is to make **dev** Dockerfiles for each one is if we make a change
**client**, **server**, **worker** we ensure to not rebuild the entire images to
get changes into a fact that makes really slow development workflow.

![dockerizing-a-react-app-again-2.png](/images/dockerizing-a-react-app-again-2.png)

## 060. Adding Postgres as a Service

![adding-postgres-as-a-service-1.png](/images/adding-postgres-as-a-service-1.png)

eg:
~~~
# create docker-compose.yml file on complex root dir and write on it:

version: '3'
services:
  postgres:
    image: 'postgres:latest'
    container_name: postgres-complex
~~~
or see:

[docker-compose.yml](./complex/docker-compose.yml)

## 061. Environment Variables with docker-compose

![environment-variables-with-docker-compose-1.png](/images/environment-variables-with-docker-compose-1.png)

```
variableName=value
```

when you use this command its mean you run 2 step process,

1. first step process
  you build an images, that's kind of preparation part create a new images.

2. second step process
  when some point on the future we run a container, we actually take an
  images and create instance of container out of it.

```
variableName
```

So if you have env-var setup on your machine like some secret API-KEY that maybe
you want to use this syntax

## 062. Nginx Path Routing

![nginx-path-routing-1.gif](/images/nginx-path-routing-1.gif)

## 063. Routing with Nginx

explaining nginx .conf file

![routing-with-nginx-1.png](/images/routing-with-nginx-1.png)

## Purpose of the Configuration File
- NGINX acts as a **reverse proxy**, routing requests to the appropriate backend services.
- The configuration file (`default.conf`) defines:
  - **Upstream servers**: Services to which requests are forwarded.
  - **Routing rules**: Instructions on how requests should be handled.
  
1. Define Upstream Servers
   - Upstream servers represent the backend services NGINX routes traffic to.
2. Set up a Server Block
   - The server block listens for incoming requests and applies routing rules.
- **Explanation**:
  - `listen 80`: NGINX listens for traffic on port `80` inside the container.
  - **Routing Rules**:
    - **`/`**: Requests to `/` are proxied to the `client` upstream (React app).
    - **`/api`**: Requests to `/api` are routed to the `api` upstream (backend service).
``` conf
upstream client {
  server client:3000;
}

upstream api {
  server api:5002;
}

server {
  listen 80;

  location / {
    proxy_pass http://client;
  }

  location /api {
    rewrite /api/(.*) /$1 break;          # a regex
    proxy_pass http://api;
  }

  location /sockjs-node {
    proxy_pass http://client;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";
  }
}
```

## Using Regex to Rewrite Paths
- **Purpose**:
  - Strip the `/api` prefix from the request before forwarding it to the backend.
- **Rewrite Rule**:
~~~
rewrite ^/api/(.*) /$1 break;
~~~
- **Explanation**:
  - **`^/api/(.*)`**:
    - Matches URLs starting with `/api/`.
    - Captures the remaining part (`.*`) after `/api/`.
  - **`/$1`**:
    - Replaces the matched part with the captured group (`.*`), effectively removing `/api`.
  - **`break`**:
    - Stops further processing of rewrite rules.

- **Example**:
  - Request: `/api/somewhere`
  - After rewrite: `/somewhere`

---
- letting react server give info back to web browser via nginx proxy

# A Continuous Integration workflow for Multiple Images 

## 063. Production Multi-container Deployment

![production-multi-container-deployment-1.png](/images/production-multi-container-deployment-1.png)

## 064. Multiple Nginx Instances

![multiple-nginx-instance-1.gif](/images/multiple-nginx-instance-1.gif)

## 065. Altering Nginx's Listen Port

On production environment nginx server has to listen on port **3000**

## 065. Travis Configuration Setup

![travis-configuration-setup-1.png](/images/travis-configuration-setup-1.png)

``` yaml
sudo: required
services:
  - docker

before_install:
  - docker build -t daun/multiple-docker-react -f ./client/Dockerfile.dev ./client

script:
  - docker run -e CI=true daun/multiple-docker-react npm test -- --coverage

after_success:
  - docker build -t <your-docker-username>/multi-client ./client
  - docker build -t <your-docker-username>/multi-nginx ./nginx
  - docker build -t <your-docker-username>/multi-server ./server
  - docker build -t <your-docker-username>/multi-worker ./worker

# Log in to docker CLI
  - echo $"DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin

# Take those images and push them to docker hub
  - docker push <your-docker-username>/multi-client
  - docker push <your-docker-username>/multi-nginx
  - docker push <your-docker-username>/multi-server
  - docker push <your-docker-username>/multi-worker
```

## 066. Pushing Images to Docker Hub

![pushing-images-to-docker-hub-1.png](/images/pushing-images-to-docker-hub-1.png)

eg:
``` yaml
# in .travis.yml
# ATTENTION ON DETAIL
# change <your-docker-username> as your docker profile

after_success:
  - docker build -t <your-docker-username>/multi-client ./client
  - docker build -t <your-docker-username>/multi-nginx ./nginx
  - docker build -t <your-docker-username>/multi-server ./server
  - docker build -t <your-docker-username>/multi-worker ./worker

# Log in to docker CLI
  - echo $"DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin

# Take those images and push them to docker hub
  - docker push <your-docker-username>/multi-client
  - docker push <your-docker-username>/multi-nginx
  - docker push <your-docker-username>/multi-server
  - docker push <your-docker-username>/multi-worker
```

# Multi Container Deployment to AWS

## 066. Multi Container Definition Files

We have a couple different folder in each of them has a separate a Dockerfile,
so any time we want to run multiple separate containers on **AWS EB** we need to
create a special file.

The new file going to be a JSON file, that to tell **EB** exactly where to pull
images from, what resources to allocate for each one, how to setup
a port-mapping, and some associated information.
![multi-container-definition-file-1.gif](/images/multi-container-definition-file-1.gif)

#### What is the different between *docker-compose.yaml* and *Dockerrun.aws.json*?

**docker-compose.yaml** have direction how to build an images and
**Dockerrun.aws.json** the image has been build just specify images to use.

```
AWS EB      # AWS ELASTIC-BEANSTALK
```

## 067. Finding Docs Container Definitions

- Elastic Beanstalk uses ECS(containers) and it uses task files something you can fill in using your docker-compose file

Is not immediately clear when you start reading AWS documentation to how to
customize **Dockerrun.aws.json**. So lets look the AWS documentation,

![finding-docs-on-container-definition-1.gif](/images/finding-docs-on-container-definition-1.gif)

```json
#Dockerrun.aws.json
{
"AWSEBDockerrunVersion":2,
  "containerDefinitions": [
    {
      "name": "client",
      "image": "<your-docker-id>/multi-client",
      "hostname": "client",      # it's name same at your docker-compose.yml services
      "essential": false         # if we remakrs with true and this container ever crashes all the other container in this group will be close-down
    },
    {
      "name": "server",
      "image": "<your-docker-id>/mulit-server",
      "hostname": "api",          # renaming hostnmae from server, cause Nginx try to redirect traffic upstream
      "essential": false
    },
    {
      "name": "worker",
      "image": "<your-docker-id>/multi-worker",
      "hostname": "worker",
      "essential": false
    },
    {
      "name": "nginx",
      "image": "<your-docker-id>/multi-nginx",
      "hostname": "nginx",       # just optional require because no other services need to directly access nginx
      "essential": true,         # if this container crash with any reason all container  must be automatically shutdown at the same time
      "portMappings": [
        {
          "hostPort": 80,        # open up a port on the host or on the machine
          "containerPort": 80    # default nginx mapped port from host
        }
      ],
      "links": ["client", "server"] # forming links from nginx over to the client container and server container
    }
  ]
}
```
- **essential tag to make other containers shutdown if it fails**
- hostname is optional field. nginx doesnt need it in this case
- port mapping in container links
- Use resource for creating elastic beanstalk in the next two resources
  
## 068. Forming Container Links

- ecs needs links to be formed, more info than dockercompose file
![forming-container-links-1.png](/images/forming-container-links-1.png)

## 069. Creating the EB Environment

!! **ATTENTION** when you create a project without a free-plane, make sure you
**DELETE** any project or AWS will charge any instances.

[cheatsheet EB](0_research/5_4_1_udemy_docker_cheatsheets.md)

![creating-the-EB-environment-1.gif](/images/creating-the-EB-environment-1.gif)

## 070. Managed Data Service Providers

- aws elastic cache managed service for redis
- aws rds managed db for postgres
![managed-data-service-providers-1.png](/images/managed-data-service-providers-1.png)

![managed-data-service-providers-2.png](/images/managed-data-service-providers-2.png)

![managed-data-service-providers-3.png](/images/managed-data-service-providers-3.png)

## 071. Overview of AWS VPC's and Security Groups

- vpc security group
![overview-of-aws-vpc-and-security-groups-1.gif](/images/overview-of-aws-vpc-and-security-groups-1.gif)

```
VPC     # Virtual Private cloud
```
![overview-of-aws-vpc-and-security-groups-2.gif](/images/overview-of-aws-vpc-and-security-groups-2.gif)

![overview-of-aws-vpc-and-security-groups-3.gif](/images/overview-of-aws-vpc-and-security-groups-3.gif)

**Security Group (firewall Rules)**: is a rules describing what different
services or sources of internet traffic can connect to different services
running inside your **VPC's**

![overview-of-aws-vpc-and-security-groups-4.gif](/images/overview-of-aws-vpc-and-security-groups-4.gif)

**Q**: Now we understand what **VPC's** is and **Security Group** is, how are we
going to form a connection between **EB Instance** with **RDS (Postgress)** and **EC
(Redis)**?

**A**: we gonna create a new security group, and new security group is going to
say essentially as a rule let any traffic access this instances if it belong to
the security group and we gonna attached it to all three of this different
services. So all the services is gonna belong to this one common security group.
And Security group essentially says if another AWS instance belong to a new
security group then let the traffic flow through and let different services talk
to each other.

## 072. RDS Databases Creation

![rds-databases-creation-1.gif](/images/rds-databases-creation-1.gif)

## 073. ElastiCache Redis Creation

![elastiCache-redis-creation-1.gif](/images/elastiCache-redis-creation-1.gif)

## 074. Creating a Custom Security Group

- create security group for 3 aws managed services to communicate with each other
![creating-a-custom-security-group-1.gif](/images/creating-a-custom-security-group-1.gif)

```
rds-launch-wizard   # a new security group automated created when you make postgress instances
```

## 075. Applying Security Groups to Resources

**ElastiCache (redis)**

![applying-security-groups-to-resources-elastiCache-1.gif](/images/applying-security-groups-to-resources-elastiCache-1.gif)

**AMAZON RDS (Postgres)**

![applying-security-groups-to-resources-rds-1.gif](/images/applying-security-groups-to-resources-rds-1.gif)

**EB Instances**

![applying-security-groups-to-resources-eb-1.gif](/images/applying-security-groups-to-resources-eb-1.gif)

## 076. Setting Environment Variables

- Grabbing environment variables for EB
![setting-environment-variables-1.gif](/images/setting-environment-variables-1.gif)

- on aws every container has access to the environment variables, not as specific as the way docker-compose adds for each container/service
**ATTENTION**
- When you put your Environment properties in **EB** the values didn't hidden, so
when you entry properties, potentially other people come to this page can see
database password.

- ElastiCache Redis at **Primary Endpoint**, we do not copy the port.

## 077. IAM Keys for Deployment

- Creating an IAM role for travis ci/jenkins producing aws secret
![iam-keys-for-deployment-1.gif](/images/iam-keys-for-deployment-1.gif)

## 078. Travis Deploy Script

![travis-deploy-script-1.gif](/images/travis-deploy-script-1.gif)

eg:
```yaml
# add this in .travis.yml

deploy:
  provider: elasticbeanstalk
  region: us-west-1
  app: multi-docker
  env: MultiDocker-env
  bucket_name: <your-bucket-name>
  bucket_path: docker-multi
  on:
    branch: master
  access_key_id: $AWS_ACCESS_KEY
  secret_access_key:
    secure: $AWS_SECRET_KEY
```

## 078. verifying deployment
- `/var/logs/ecs/ecs-int.log`
  
## 079. Container Memory Allocations

![container-memory-allocations-1.gif](/images/container-memory-allocations-1.gif)

## 080. Cleaning Up AWS Resources

![cleaning-up-aws-resources-1.gif](/images/cleaning-up-aws-resources-1.gif)

# == Kubernetes ==

![the-why-and-what-of-kubernetes-1.gif](/images/the-why-and-what-of-kubernetes-1.gif)

# What is Kubernetes?

Is a system for running many different containers over multiple different
machines

![the-why-and-what-of-kubernetes-2.gif](/images/the-why-and-what-of-kubernetes-2.gif)

# Why use Kubernetes?

When you need to run many different containers with different images

![the-why-and-what-of-kubernetes-1.png](/images/the-why-and-what-of-kubernetes-1.png)

## 081. Kubernetes in Development and Production

![kubernetes-in-development-and-production-1.gif](/images/kubernetes-in-development-and-production-1.gif)

```
minikube  # a command line tools to setup a tiny kubernetes cluster

kubectl   # is a program use to interact kubernetes cluster in general
```

## 082. Mapping Existing Knowledge

![mapping-existing-knowledge-1.gif](/images/mapping-existing-knowledge-1.gif)

## 083. Adding Configuration file

```
k8s   # a convention term | abbervation for kubernetes
```
[client-pod.yaml](./simplek8s/client-pod.yaml)

[client-node-port.yaml](./simplek8s/client-node-port.yaml)

![object-types-and-api-version-1.gif](/images/object-types-and-api-version-1.gif)

explanation config file

```
apiVersion: v1            # scope or limits the type of object
kind: Pod                 # a specific type of object
metadata: client-pod      # most of use is for logging purposes
  name: client-pod
  labels:
    component: web        # a label selector system to connect with client-node-port.yaml
```

when we make config file kubernetes we not quite making a **container** me make
something different we make an **object**.

**Q**: what is an object is on kubernetes?

**A**: a config file we set (make) the term object is refer to a **think** that
exist inside at kubernetes cluster, so we don't specifically says we make an
object so much, reality we make specific **type of object**

**Q**: what is an object use for on kubernetes?

**A**: object is essentially think that going to be created inside kuberntes cluster
to get application to work the way we might expect. Every object or type of
object have slightly different purpose

**Q**: what is Object types of Pod use for?

**A**: a Pod use to running a container

**Q**: what is object types ReplicaController use for?

**A**: a ReplicaController use for monitoring a container

**Q**: what is object types Service use for?

**A**: a Service use for up networking

## 084. Running Containers in Pods

![running-containers-in-pods-1.gif](/images/running-containers-in-pods-1.gif)

When we start to load-up the configuration file into **kubectl** is going to
create a **Pod** inside Virtual-Machine (we refer VM as a Node). A **Pod** it
self it's a grouping of containers with very common purpose.

**Q**: We might be wondering why me making a **Pod** that has a grouping a container?

**A**: In the kubernetes world there is no such think as just creating
a container on a cluster

back with **EB**, **docker-compose** we were creating containers really old-day
no shoe what so ever. In the world kubernetes we do not have the ability to just
run one naked single container by it self with no associated over had. The
smallest think you can deploy is a **Pod**.

It always to be declare or deploying containers within a **Pod**, as the
smallest think we can deploy to run a single container.

**Q**: why me make a **Pod**?

**A**: we cannot deploy individual containers by them self as we could with
docker-compose, DB requirement of a **Pod** we must run one or more containers
inside of it.

In the world of **Pod** we start to grouping together containers that have
a very discrete or very tightly couple relationship, in other words these
are containers absolutely have a tight immigration and must be executed with each
others.

## 085. Service Config Files in Depth

![service-config-files-in-depth-1.gif](/images/service-config-files-in-depth-1.gif)

We use this Second object (**service**) types any times we want to setup some amount of
networking inside of kubernetes cluster.

eg:
```yaml
# client-node-port.yaml

apiVersion: V1
kind: Service
metadata:
  name: client-node-port
spec:
  types: NodePort
  ports:
    - port: 3050
      targetPort: 3000
      nodePort: 31515     # Expose a container to the outside world | for dev environment purpose
  selector:               # a label-selector-system
    component: web
```

```
kube-proxy      # a single window to the outside world
```
rather then referring to the **Service** to connect to the **client-pod.yaml**,
we instead using in kubernetes **label-selector-system**. To connect between
**client-node-port.yaml** with **client-pod.yaml**

A **component: web** is arbitrary key-value pair.

A **targetPort: 3000** is identical to the **containerPort: 3000** over the
**Pod** definition

A **nodePort** the most IMPORTANT is to communicated between developer to access
**multi-client Pod**