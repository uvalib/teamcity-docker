#
# script to display the details of the specified change or set of changes
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

# results file
RESFILE=/tmp/$FNAME.$$

if [ $# -eq 0 ]; then
   echo "ERROR: no change numbers specified, aborting"
   exit 1
fi

rm $RESFILE > /dev/null 2>&1

while [ $# -gt 0 ]; do
   CHANGE_ID=$1
   curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" "$TEAMCITY_API/changes/id:($CHANGE_ID)" >> $RESFILE 2>/dev/null
   exit_on_error $?
   shift
done

cat $RESFILE | jq '"\(.comment) (\(.username))"' | tr -d "\"" | sed -e 's&\\n&&g'
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
