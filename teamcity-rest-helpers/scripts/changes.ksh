#
# script to display the set of changes associated with the specified build
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

if [ -z "$TEAMCITY_PROJECT" ]; then
   echo "ERROR: no TEAMCITY_PROJECT defined, aborting"
   exit 1
fi 

# results file
RESFILE=/tmp/$FNAME.$$

if [ $# -ne 1 ]; then
   echo "ERROR: build number not specified, aborting"
   exit 1
fi

# get the TC build identifier
BUILD="build-$1"
ID=$($DIR/builds.ksh | grep $BUILD | awk '{print $2}')
if [ -z "$ID" ]; then
   echo "ERROR: cannot locate $BUILD for project $TEAMCITY_PROJECT, aborting"
   exit 1
fi

curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" "$TEAMCITY_API/changes?locator=build:($ID)" > $RESFILE 2>/dev/null
exit_on_error $?

cat $RESFILE | jq '.change[] | "\(.id)"' | tr -d "\"" | sort -rn | xargs $DIR/change.ksh
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
