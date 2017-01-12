if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

echo "*****************************************"
echo "removing server on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=teamcity-server
NAMESPACE=jetbrains
HOST_FS=/shareddockerfs/teamcity

echo "stopping server..."
docker stop $INSTANCE
docker rm -f $INSTANCE
echo "removing image..."
docker rmi -f $NAMESPACE/$INSTANCE
