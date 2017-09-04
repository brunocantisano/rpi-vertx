#!/bin/bash
set -e

trap appStop SIGINT SIGTERM

# Variables
VERTICLE_HOME=${VERTICLE_HOME:-/usr/verticles}
VERTICLE_NAME=${VERTICLE_NAME:-io.vertx.sample.hello.HelloVerticle}
VERTICLE_FILE=${VERTICLE_FILE:-target/hello-verticle-3.2.0.jar}

appCompile () {
  set +e
  echo "Creating vertx app..."
  mvn package
}

appStop () {
  echo "Stopping vertx app..."
}

appServer () {
  set +e
  echo "Starting server..."
  exec vertx run ${VERTICLE_NAME} -cp ${VERTICLE_HOME}/*
  tail -f /dev/null
}

appHelp () {
  echo "Available options:"
  echo " app:compile        - Creates a vertx app"
  echo " app:server         - Starts the vertx server (default)"
  echo " app:help           - Displays the help"
  echo " [command]          - Execute the specified linux command eg. bash."
}

case "$1" in
  app:compile)
    appCompile
    ;;
  app:server)
    appServer
    ;;
  app:help)
    appHelp
    ;;
  *)
    if [ -x $1 ]; then
      $1
    else
      prog=$(which $1)
      if [ -n "${prog}" ] ; then
        shift 1
        $prog $@
      else
        appHelp
      fi
    fi
    ;;
esac

exit 0
