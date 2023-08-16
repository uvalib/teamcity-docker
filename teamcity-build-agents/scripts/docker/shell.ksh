#if [ -z "$DOCKER_HOST" ]; then
#   echo "ERROR: no DOCKER_HOST defined"
#   exit 1
#fi

if [ -z "$DOCKER_HOST" ]; then
   DOCKER_TOOL=docker
else
   DOCKER_TOOL=docker-legacy
fi

# set the definitions
INSTANCE=uva-teamcity-agent
NAMESPACE=uvadave

$DOCKER_TOOL run -ti $NAMESPACE/$INSTANCE /bin/bash -l
