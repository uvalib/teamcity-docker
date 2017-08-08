#
# script to qurty TeamCity for the list of projects and present as a menu
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

# results file
RESFILE=/tmp/$FNAME.$$
rm $RESFILE > /dev/null 2>&1

$DIR/projects.ksh > $RESFILE
exit_on_error $?

projects=($(cat $RESFILE | grep "=>" | grep -v "Root project" | cut -d\  -f3- | tr " " "_" | awk '{printf "%s ", $0}'))
PS3='Select teamcity project: '

select opt in "${projects[@]}"
do
    case $opt in
    *)
    SELECTED=$(echo $opt | tr "_" " ")
    ID=$(grep "${SELECTED}$" $RESFILE | awk '{print $1}' | sed -e 's/^id://g')
    echo "export TEAMCITY_PROJECT=$ID"
    break
    ;;
    esac
done

rm $RESFILE > /dev/null 2>&1

#
# end of file
#
