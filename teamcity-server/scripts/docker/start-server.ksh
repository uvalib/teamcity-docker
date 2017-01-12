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
HOST_FS=/shareddockerfs/teamcity

# taken from blog pages
TEAMCITY_SERVER_MEM_OPTS="-Xmx2g -XX:MaxPermSize=270m -XX:ReservedCodeCacheSize=350m" 

echo "stopping server..."
docker stop $INSTANCE
docker rm $INSTANCE

echo "starting server..."
docker run -d -p 8080:8111 --name $INSTANCE \
   -e TEAMCITY_SERVER_MEM_OPTS="$TEAMCITY_SERVER_MEM_OPTS" \
   -v $HOST_FS/datadir:/data/teamcity_server/datadir \
   -v $HOST_FS/logs:/opt/teamcity/logs \
   $NAMESPACE/$INSTANCE
