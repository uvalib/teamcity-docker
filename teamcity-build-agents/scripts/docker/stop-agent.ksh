if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined, aborting"
   exit 1
fi

if [ $# -ne 1 ]; then
   echo "ERROR: must specify agent number, aborting"
   exit 1
fi

echo "*****************************************"
echo "stopping agent on $DOCKER_HOST"
echo "*****************************************"

agent=agent${1}

echo "stopping ${agent}"
docker stop ${agent}
echo "removing ${agent}"
docker rm ${agent}
