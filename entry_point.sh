#!/bin/bash

EXIT_CODE=0

echo "SCREEN_WIDTH => $SCREEN_WIDTH"
echo "SCREEN_HEIGHT => $SCREEN_HEIGHT"
echo "SCREEN_DEPTH => $SCREEN_DEPTH"

export GEOMETRY="${SCREEN_WIDTH:-1920}""x""${SCREEN_HEIGHT:-1080}""x""${SCREEN_DEPTH:-24}"

echo "GEOMETRY => $GEOMETRY"

function shutdown {
  kill -s SIGTERM $NODE_PID
  sleep 10
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi


rm -f /tmp/.X*lock

sudo -u seluser xvfb-run -a --server-args="-screen 0 $GEOMETRY -ac +extension RANDR +extension DOUBLE-BUFFER +extension GLX +extension MIT-SHM" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT

sleep 10

COMMAND="$@"
echo "COMMAND => $COMMAND"
exec $COMMAND
EXIT_CODE=$?

shutdown

exit $EXIT_CODE
