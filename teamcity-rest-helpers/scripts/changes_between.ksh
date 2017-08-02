#
# script to display the set of changes associated with a range of builds
#

DIR=$(dirname $0)

# source common
. $DIR/common.ksh

if [ $# -ne 2 ]; then
   echo "ERROR: build range not specified, aborting"
   exit 1
fi

# define the build range
FIRST=$1
LAST=$2

for build in $(seq $FIRST $LAST); do

   echo "* build: $build"
   $DIR/changes.ksh $build
   echo ""
done

#
# end of file
#
