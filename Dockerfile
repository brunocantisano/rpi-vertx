###
# vert.x docker example using a Java verticle
# To build:
#  docker build -t paperinik/rpi-vertx .
# To run:
#   docker run -t -i -p 8080:8080 paperinik/rpi-vertx
###
FROM paperinik/rpi-java8
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

RUN apt-get clean && apt-get update \
    && apt-get install wget -y \
    && mkdir -p /usr/verticles \
    && wget https://bintray.com/vertx/downloads/download_file?file_path=vert.x-3.2.0.tar.gz -O /usr/verticles/vert.x-3.2.0.tar.gz \
    && tar -xvzf /usr/verticles/vert.x-3.2.0.tar.gz && rm -f /usr/verticles/vert.x-3.2.0.tar.gz \
    && apt-get purge --auto-remove wget \
    && rm -rf /var/lib/apt/lists/*

ENV VERTICLE_NAME io.vertx.sample.hello.HelloVerticle
ENV VERTICLE_FILE target/hello-verticle-3.2.0.jar

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

EXPOSE 8080

# Copy your verticle to the container
COPY $VERTICLE_FILE $VERTICLE_HOME/

# Launch the verticle
WORKDIR $VERTICLE_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["exec vertx run $VERTICLE_NAME -cp $VERTICLE_HOME/*"]
