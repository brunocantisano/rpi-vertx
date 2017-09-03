###
# vert.x docker example using a Java verticle
# To build:
#  docker build -t paperinik/rpi-vertx .
# To run:
#   docker run -t -i -p 9409:3000 paperinik/rpi-vertx
###
FROM paperinik/rpi-maven:latest
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Vert.x 3.2.0 Container

ENV VERTICLE_NAME io.vertx.sample.hello.HelloVerticle
ENV VERTICLE_FILE target/hello-verticle-3.2.0.jar

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

# Copy your verticle to the container
COPY $VERTICLE_FILE $VERTICLE_HOME/
COPY files/entrypoint.sh $VERTICLE_HOME/

RUN apt-get clean && apt-get update \
    && apt-get install -y wget \
    && cd / \
    && mkdir -p /usr/verticles \
    && wget https://bintray.com/vertx/downloads/download_file?file_path=vert.x-3.2.0.tar.gz -O /usr/verticles/vert.x-3.2.0.tar.gz \
    && tar -xvzf /usr/verticles/vert.x-3.2.0.tar.gz \
    && rm -f /usr/verticles/vert.x-3.2.0.tar.gz \
    && chmod 755 $VERTICLE_HOME/entrypoint.sh \
    && apt-get purge --auto-remove wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

VOLUME $VERTICLE_HOME

# Launch the verticle
WORKDIR $VERTICLE_HOME

ENTRYPOINT ["$VERTICLE_HOME/entrypoint.sh"]

CMD ["app:server"]