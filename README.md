# Vertx

![docker_logo](https://raw.githubusercontent.com/brunocantisano/rpi-vertx/master/files/docker.png)![docker_vertx_logo](https://raw.githubusercontent.com/brunocantisano/rpi-vertx/master/files/logo-vertx.png)![docker_paperinik_logo](https://raw.githubusercontent.com/brunocantisano/rpi-vertx/master/files/docker_paperinik_120x120.png)

This Docker container implements vertx on Raspberry pi.

 * Raspbian base image: [resin/rpi-raspbian](https://hub.docker.com/r/resin/rpi-raspbian/)
 * Vertx 3.2.0
 
### Installation from [Docker registry hub](https://registry.hub.docker.com/u/paperinik/rpi-vertx/).

You can download the image with the following command:

```bash
docker pull paperinik/rpi-vertx
```

# How to use this image

Use cases
----
Exposed ports and volumes
* The Vertx instance starts listening on the default port of `3000` on the container. Also, exports one volume: `/usr/verticles`, which contains vertx apps.
----
Environment variables
* Variable name: `VERTICLE_NAME`
* Default value: io.vertx.sample.hello.HelloVerticle
* Description: you must inform a valid verticle name in order to run this container.
----
* Variable name: `VERTICLE_FILE`
* Default value: target/hello-verticle-3.2.0.jar
* Accepted values: jar path 
* Description: you must inform a valid jar path in order to run this container.
----

1) Run a container with a binded data directory:
```bash
docker run --name vertx -d -p 9416:3000 \
           --env VERTICLE_NAME=io.vertx.sample.hello.HelloVerticle \
           --env VERTICLE_FILE=target/hello-verticle-3.2.0.jar \
           -v /media/usbraid/docker/vertx:/usr/verticles \
           paperinik/rpi-vertx
```