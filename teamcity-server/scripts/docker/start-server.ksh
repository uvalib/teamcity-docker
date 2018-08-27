if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

echo "*****************************************"
echo "starting server on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=teamcity-server
NAMESPACE=jetbrains
#TAG=latest
TAG=2018.1.1

HOST_FS=/shareddockerfs/teamcity

# pull base image to ensure we have the correct one
#docker pull $NAMESPACE/$INSTANCE:$TAG

# taken from blog pages
TEAMCITY_SERVER_MEM_OPTS="-Xmx4g -XX:ReservedCodeCacheSize=350m" 

echo "stopping server..."
docker stop $INSTANCE
docker rm $INSTANCE

echo "starting server..."
docker run -d -p 8080:8111 --name $INSTANCE \
   --log-opt tag=$INSTANCE \
   --restart=always \
   -e TEAMCITY_SERVER_MEM_OPTS="$TEAMCITY_SERVER_MEM_OPTS" \
   -v $HOST_FS/datadir:/data/teamcity_server/datadir \
   -v $HOST_FS/logs:/opt/teamcity/logs \
   $NAMESPACE/$INSTANCE:$TAG
