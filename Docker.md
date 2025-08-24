# Docker

- [Docker](#docker)
  - [Docker Compose](#docker-compose)
  - [Docker Volumes](#docker-volumes)
    - [Lists all Docker volumes](#lists-all-docker-volumes)
    - [Inspects a volume to view detailed information about it](#inspects-a-volume-to-view-detailed-information-about-it)
    - [Creates a new volume](#creates-a-new-volume)
    - [Removes a volume](#removes-a-volume)
    - [Removes all unused volumes](#removes-all-unused-volumes)
  - [Docker Images](#docker-images)
    - [Lists Docker images](#lists-docker-images)
    - [Inspects an image to retrieve detailed information](#inspects-an-image-to-retrieve-detailed-information)
    - [Pulls a Docker image](#pulls-a-docker-image)
    - [History of an image](#history-of-an-image)
  - [Docker Containers](#docker-containers)
    - [Lists all running containers](#lists-all-running-containers)
    - [Runs a container in detached mode (in the background)](#runs-a-container-in-detached-mode-in-the-background)
    - [Runs a container interactively with a terminal session](#runs-a-container-interactively-with-a-terminal-session)
    - [Executes a command in a running container with an interactive terminal](#executes-a-command-in-a-running-container-with-an-interactive-terminal)

## Docker Compose

```bash
# Starts up services defined in a docker-compose.yml file in detached mode (background).
docker-compose up -d
```

## Docker Volumes

### Lists all Docker volumes

```bash
docker volume ls
```

### Inspects a volume to view detailed information about it

```bash
docker volume inspect VOLUME_NAME
```

### Creates a new volume

```bash
docker volume create VOLUME_NAME
```

### Removes a volume

```bash
docker volume rm VOLUME_NAME
```

### Removes all unused volumes

```bash
docker volume prune
```

## Docker Images

### Lists Docker images

```bash
docker image ls
```

### Inspects an image to retrieve detailed information

```bash
docker image inspect <image>
```

### Pulls a Docker image

```bash
docker pull <image_name>
```

### History of an image

```bash
docker image history <image>
```

## Docker Containers

### Lists all running containers

```bash
docker ps
```

### Runs a container in detached mode (in the background)

```bash
docker run -d <image>
```

### Runs a container interactively with a terminal session

```bash
docker run -i -t <image>
```

### Executes a command in a running container with an interactive terminal

```bash
docker exec -i -t <container_name> <command>
```
