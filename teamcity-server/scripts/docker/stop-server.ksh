if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

echo "*****************************************"
echo "stopping server on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=teamcity-server

echo "stopping server..."
docker stop $INSTANCE
docker rm $INSTANCE
