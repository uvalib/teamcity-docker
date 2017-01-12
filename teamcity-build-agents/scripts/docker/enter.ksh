if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

if [ $# -eq 0 ]; then
   echo "ERROR: no agent name defined"
   exit 1
fi

echo "*****************************************"
echo "entering on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=$1

CID=$(docker ps -f name=$INSTANCE|tail -1|awk '{print $1}')
if [ -n "$CID" ]; then
   docker exec -it $CID /bin/bash -l
else
   echo "No running container for $INSTANCE"
fi

