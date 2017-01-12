if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

# set the definitions
INSTANCE=uva-teamcity-agent
NAMESPACE=uvadave

docker run -ti $NAMESPACE/$INSTANCE /bin/bash -l
