#
# Push the current team city agent build to the AWS registry
#

# check commandline
if [ $# -ne 1 ]; then
   echo "use: $(basename $0) <new build tag>"
   exit 0
fi

# the tag...
BUILD_TAG=$1

# helper dir
HELPER_DIR=$HOME/Sandboxes/build-deploy-scripts

# source the necessary support
. $HELPER_DIR/common/aws-support.ksh

# define the upload tool to use
UPLOADER_TOOL=$HELPER_DIR/common/upload-to-ecr.ksh

if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

if [ ! -x "$UPLOADER_TOOL" ]; then
   echo "ERROR: $UPLOADER_TOOL is not available"
   exit 1
fi

# upload the latest image
$UPLOADER_TOOL $DOCKER_HOST uvadave/uva-teamcity-agent:latest $AWS_DEFAULT_REGISTRY/uvalib/teamcity-agent:latest
res=$?
if [ $res -ne 0 ]; then
   echo "ERROR: pushing latest image"
   exit 1
fi

# and the tagged one
$UPLOADER_TOOL $DOCKER_HOST uvadave/uva-teamcity-agent:latest $AWS_DEFAULT_REGISTRY/uvalib/teamcity-agent:$BUILD_TAG
res=$?
if [ $res -ne 0 ]; then
   echo "ERROR: pushing tagged image"
   exit 1
fi

echo "Terminating successfully"
exit 0

#
# end of file
#
