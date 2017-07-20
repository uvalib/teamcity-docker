#
# script to display the set of projects know about by TeamCity
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

# results file
RESFILE=/tmp/$FNAME.$$

curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" "$TEAMCITY_API/projects" > $RESFILE 2>/dev/null
exit_on_error $?

cat $RESFILE | jq '.project[] | "\(.name)  id:\(.id)"' | tr -d "\"" | sort
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
