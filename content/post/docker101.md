+++
description = "Docker Introduction"
title = "Docker 101"
date = 2020-06-11T17:27:08+08:00
tags = ["Docker"]
author = "Ken Cho"

+++

### What is Docker?
![img](/image/docker_beginner.webp)

> In simpler words, Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.

>The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development.

>Unlike virtual machines, containers do not have high overhead and hence enable more efficient usage of the underlying system and resources.

![img](/image/docker_os.jpeg)
>Docker runs containers, which use the same host operating system, and only virtualize at a software level.

>Docker Engine runs on Linux, Windows, and macOS, and supports Linux and Windows for Docker containers.

![imag](/image/docker_flow.jpeg)

### What is Dockerfile?
A Dockerfile is the recipe to build a Docker image.
This is the workflow: first you create a Dockefile, then you built a Docker image from it using docker build, and finally you run a container from the image.
A Dockerfile is a text file with instructions on how to build an image.
Those instructions are part of a configuration language, which includes keywords like FROM, LABEL, RUN, COPY, ENTRYPOINT, CMD, EXPOSE, ENV and more.

### Example Dockerfile
Let’s say you have a folder with a simple Node.js app composed by an app.js, a package.json file that lists a couple dependencies you need to install before running the app, and package-lock.json.  
```dockerfile
FROM node:14
WORKDIR /usr/src/app
COPY package*.json app.js ./
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]
```
Details please go to [Dockerfile 1](https://flaviocopes.com/docker-dockerfiles/) and [Dockerfile 2](https://flaviocopes.com/docker-node-container-example/).

### Learn Docker in 5 days !!!
[Day1-General Concepts](https://medium.com/faun/learn-docker-in-5-days-day-1-general-concepts-fcac5a4cf0a6)
[Day2-Basic Commands](https://medium.com/faun/learn-docker-in-5-days-day-2-basic-commands-f1dad39925c6)
[Day3-Sotrage and Networks](https://medium.com/faun/learn-docker-in-5-days-day-3-storage-and-networks-6c11f645017d)
[Day4-Dockerfiles](https://medium.com/faun/learn-docker-in-5-days-day-4-dockerfiles-a39935f53e6b)
[Day5-Docker compose](https://medium.com/faun/learn-docker-in-5-days-day-5-docker-compose-11af7b9298db) 

### Playing with Docker
1. `pull` the image from docker registry  
`docker pull busybox`  
2. list images  
`docker images`  
3. run a docker container based on `busybox` image  
`docker run busybox echo "hello from busybox`   
4. show running containers  
`docker ps`  
`docker ps -a` 
`docker container ls`   
5. go into a docker container  
`docker run -it busybox sh`  
>>Since Docker creates a new container every time, everything will be rebuilt again in each instance.
6. `docker run` multiple times and leaving stray containers will eat up disk space. `docker rm` to clean up containers.  
`docker rm contain-ID`  
`docker rm $(docker ps -a -q -f status=exited)`  
-q: return numeric ID  
-f: filters output based on conditions provided  
`docker container prune` can be used to remove all the stopped containers. 
7. to delete docker images  
`docker rmi`   
8. Build a container from an image and remove it when it exits.  
`docker run --rm image`  
`docker run -d -P --name xxx image`  
`-d`: will detach terminal  
`-p`: publish all exposed port to random ports  
`--name`: container name we want to give   
9. Check the ports, then open `http://localhost:port` in browser.  
`docker port xxx`  
10. to stop a detached container  
`docker stop xxx`  


### Terminology
- `Images`: the blueprints form the basis of containers.  
- `Containers`: created from docker images and run the actual application.  
- `Docker Daemon`: the background service running on the host that manage building, running and distributing docker containers.
- `Docker Client`: The command line tool that allows the user to interact with the daemon.  
- `Docker Hub`: A registry of docker images.  

### Docker Images
Docker images are the basis of containers. To see the list of images that are available locally, use the `docker images` command.

### How to build an image
1. `git clone` [dokcer repo](https://github.com/prakhar1989/docker-curriculum)  
2. `cd docker-curriculum/flask-app`  
3. make `Dockerfile`: a simple text file that contains a list of commands that the Docker client calls while creating an image.
4. create docker image from a `Dockerfile`  
`docker build -t test/flask . `
`-t`: optional tag name  
5. run the image  

### How To Remove Docker Images, Containers, and Volumes?
1. To clean up any resources — images, containers, volumes, and networks — that are dangling (not associated with a container)  
`docker system prune`  
2. To additionally remove any stopped containers and all unused images (not just dangling images), add the `-a` flag to the command  
`docker system prune -a`  
3. More usages, can go to [here](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)  






### Reference
1. [Docker Containers 101](https://www.youtube.com/watch?v=eGz9DS-aIeY)
2. [Docker curriculum](https://docker-curriculum.com/)
3. [How to write a docker file](https://semaphoreci.com/blog/docker-benefits)
4. [Doker for beginners](https://github.com/groda/big_data/blob/master/docker_for_beginners.md)
5. [What does Docker do, and when should you use it?](https://www.cloudsavvyit.com/490/what-does-docker-do-and-when-should-you-use-it/)
6. [Getting Started with Docker for Developers](https://dev.to/pavanbelagatti/getting-started-with-docker-for-developers-3apo)
7. [How to remove docker images, containers and volumes](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)
8. [How to remove Docker Images, Containers and Volumes](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)
9. [How to share data between docker containers](https://www.digitalocean.com/community/tutorials/how-to-share-data-between-docker-containers)

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)
